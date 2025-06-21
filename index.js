import { Telegraf } from 'telegraf';
import fetch from 'node-fetch';
import fs from 'fs/promises';
import dotenv from 'dotenv';
import express from 'express';
import sqlite3 from 'sqlite3';
import { open } from 'sqlite';
import { setupCheats } from './cheat.js'; // без require

dotenv.config();

const BOT_TOKEN = process.env.BOT_TOKEN || 'ТВОЙ_ТОКЕН_ЗДЕСЬ';
const bot = new Telegraf(BOT_TOKEN);

const ADMINS_FILE = './admins.json';

// ⚠️ Минимальный сервер для Scalingo
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Бот работает ✅');
});

app.listen(PORT, () => {
  console.log(`🌐 Сервер слушает порт ${PORT}`);
});

// Загрузка admins.jslon
async function loadAdmins() {
  try {
    const data = await fs.readFile(ADMINS_FILE, 'utf8');
    const json = JSON.parse(data);
    if (json && Array.isArray(json.admins)) return json;
    return { admins: [] };
  } catch {
    return { admins: [] };
  }
}

// Сохранение admins.json
async function saveAdmins(data) {
  await fs.writeFile(ADMINS_FILE, JSON.stringify(data, null, 2));
}

// Получить уровень доступа пользователя
async function getAdminLevel(userId) {
  const data = await loadAdmins();
  const admin = data.admins.find(a => a.id === userId);
  return admin ? admin.level : 0;
}

// Проверка уровня доступа
async function hasLevel(userId, level) {
  return (await getAdminLevel(userId)) >= level;
}

// Добавить админа (уровень 3 - полный доступ)
async function addAdmin(id, level, nickname = '') {
  const data = await loadAdmins();
  if (data.admins.find(a => a.id === id)) return false;
  data.admins.push({ id, level, nickname });
  await saveAdmins(data);
  return true;
}

// Добавить заместителя (уровень 1)
async function addZam(id, nickname) {
  const data = await loadAdmins();
  if (data.admins.find(a => a.id === id)) return false;
  data.admins.push({ id, level: 1, nickname });
  await saveAdmins(data);
  return true;
}

// Удалить пользователя из admins.json
async function delAdmin(id) {
  const data = await loadAdmins();
  const beforeLen = data.admins.length;
  data.admins = data.admins.filter(a => a.id !== id);
  if (data.admins.length === beforeLen) return false;
  await saveAdmins(data);
  return true;
}

// Команда: /accept ID - выдать полный доступ (уровень 3)
bot.command('accept', async ctx => {
  if (!(await hasLevel(ctx.from.id, 3))) return ctx.reply('🚫 Нет доступа.');
  const args = ctx.message.text.split(' ');
  if (args.length < 2) return ctx.reply('Использование: /accept ID');
  const userId = Number(args[1]);
  if (isNaN(userId)) return ctx.reply('ID должен быть числом.');
  const added = await addAdmin(userId, 3);
  ctx.reply(added ? `✅ Доступ выдан пользователю ${userId}` : '❌ Пользователь уже имеет доступ.');
});

// Команда: /addzam ID Nickname - добавить зама (уровень 1)
bot.command('addzam', async ctx => {
  if (!(await hasLevel(ctx.from.id, 3))) return ctx.reply('🚫 Нет доступа.');
  const args = ctx.message.text.split(' ');
  if (args.length < 3) return ctx.reply('Использование: /addzam ID Nickname');
  const userId = Number(args[1]);
  const nickname = args.slice(2).join(' ');
  if (isNaN(userId)) return ctx.reply('ID должен быть числом.');
  const added = await addZam(userId, nickname);
  ctx.reply(added ? `✅ Заместитель ${nickname} добавлен` : '❌ Этот пользователь уже есть в списке.');
});

// Команда: /zam - список замов и админов (уровень >=1)
bot.command('zam', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
  const data = await loadAdmins();
  if (data.admins.length === 0) return ctx.reply('Список пуст.');
  let list = '👥 <b>Список заместителей и админов:</b>\n\n';
  data.admins.forEach(a => {
    list += `• ID: <code>${a.id}</code> | Ник: ${a.nickname || 'неизвестно'} | Уровень: ${a.level}\n`;
  });
  ctx.replyWithHTML(list);
});

// Команда: /online - вывод онлайн (уровень >=1)

async function fetchOnlineData() {
  const res = await fetch('http://launcher.hassle-games.com:3000/online.json')
  return await res.json()
}

function generateOnlineText(crmp) {
  let total = 0
  let text = `S | R » Онлайн проекта "<a href="https://t.me/hassleonline"><b>RADMIR CR:MP</b></a>"\n\n`

  for (const [id, server] of Object.entries(crmp)) {
    const sid = id.toString().padStart(2, '0')
    const players = server.players || 0
    const bonus = server.bonus || 1
    total += players
    text += `${sid}. "<a href="https://t.me/hassleonline">SERVER ${sid}</a> <b>[x${bonus}]</b>", онлайн: <b>${players}</b>\n`
  }

  text += `\n— Суммарный онлайн: <b>${total}</b>`
  return text
}
bot.command('online', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) {
    return ctx.reply('🚫 Нет доступа.')
  }
  try {
    const data = await fetchOnlineData()
    const crmp = data.crmp_new
    const message = generateOnlineText(crmp)

    await ctx.reply(message, {
      parse_mode: 'HTML',
      disable_web_page_preview: true
    })
  } catch (e) {
    console.error(e)
    ctx.reply('❌ Не удалось получить онлайн.')
  }
})

// Команда: /sobes - заглушка
bot.command('sobes', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) {
    return ctx.reply('🚫 Нет доступа.');
  }

  ctx.reply('Разработчик пошёл пить пиво 🍺');
});

// Команда: /del ID - снять доступ (уровень 3)
bot.command('del', async ctx => {
  if (!(await hasLevel(ctx.from.id, 3))) return ctx.reply('🚫 Нет доступа.');
  const args = ctx.message.text.split(' ');
  if (args.length < 2) return ctx.reply('Использование: /del ID');
  const userId = Number(args[1]);
  if (isNaN(userId)) return ctx.reply('ID должен быть числом.');
  const deleted = await delAdmin(userId);
  ctx.reply(deleted ? `✅ Доступ пользователя ${userId} удалён.` : '❌ Пользователь не найден.');
});

// Команда: /update - Информация о обновлении
bot.command('update', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) {
    return ctx.reply('🚫 Нет доступа.');
  }

  const text = `
📦 <b>Обновление бота</b>

<b>Изменения 19.06 | 1.1 </b>
• <code>/online</code> — убрана кнопка "Обновить данные" для стабильной работы
• Добавлена проверка уровня доступа (>=1) для безопасности
• Мелкие оптимизации и чистка кода

<b>Изменения 20.06 | 1.2 </b>
• Добавлена команда <code>/sub</code> и <code>/unsub</code> для подписки на уведомления о стримах Мараса Шакала
• Переработана систиме проверки доступа к командам
• Исправлена задержка <code>/online</code> при использовании
• Добавлена функционал под команду <code>/admins</code> просмотр списка админов на 19 SERVERE (уровень >=3) (BETA)

💡 Продолжаем развивать функционал! Если есть предложения — пиши ✉️ <a href="https://t.me/Developer116">@Developer116</a>
  `;

  ctx.replyWithHTML(text, { disable_web_page_preview: true });
});

// 📦 Инициализация базы данны
let db;
(async () => {
  db = await open({
    filename: './stream_subscribers.db',
    driver: sqlite3.Database
  });

  await db.exec(`
    CREATE TABLE IF NOT EXISTS subscribers (
      user_id INTEGER PRIMARY KEY
    );
  `);
})();

// 📩 Подписка
bot.command('sub', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) {
    return ctx.reply('🚫 Нет доступа.');
  }

  try {
    await db.run('INSERT OR IGNORE INTO subscribers (user_id) VALUES (?)', [ctx.from.id]);
    ctx.reply('✅ Вы подписались на уведомления о стримах Мараса Шакира!');
  } catch (err) {
    ctx.reply('❌ Ошибка при подписке.');
  }
});

// ❌ Отписка
bot.command('unsub', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) {
    return ctx.reply('🚫 Нет доступа.');
  }

  try {
    await db.run('DELETE FROM subscribers WHERE user_id = ?', [ctx.from.id]);
    ctx.reply('❎ Вы отписались от уведомлений.');
  } catch (err) {
    ctx.reply('❌ Ошибка при отписке.');
  }
});

// 🔔 Рассылка уведомлений
async function notifyAll(message) {
  const subscribers = await db.all('SELECT user_id FROM subscribers');
  for (const user of subscribers) {
    bot.telegram.sendMessage(user.user_id, message).catch(() => {});
  }
}

// 📺 Проверка стрима (YouTube Data API НЕ используется — парсинг страницы)
let lastStreamId = null;

async function checkLiveStream() {
  try {
    const res = await fetch('https://m.youtube.com/@MarasShakur/live');
    const html = await res.text();

    const videoIdMatch = html.match(/"videoId":"(.*?)"/);
    const isLive = html.includes('"isLiveNow":true');

    if (videoIdMatch && isLive) {
      const videoId = videoIdMatch[1];

      if (videoId !== lastStreamId) {
        lastStreamId = videoId;
        const url = `https://www.youtube.com/watch?v=${videoId}`;
        await notifyAll(`🔴 Марас Шакир запустил стрим!\n📺 Смотри тут: ${url}`);
        console.log(`Отправлено уведомление: ${url}`);
      }
    }
  } catch (err) {
    console.error('Ошибка при проверке стрима:', err.message);
  }
}

// 🔁 Проверка каждые 2 минуты
setInterval(checkLiveStream, 2 * 60 * 1000);

bot.command('admins', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) {
    return ctx.reply('🚫 Нет доступа.');
  }

  ctx.reply('Данная команда находится в разработке ⚒️');
});

setupCheats(bot, hasLevel);

// Запуск бота
bot.launch()
  .then(() => console.log('✅ Бот запущен'))
  .catch(err => console.error('❌ Ошибка запуска бота:', err));

// Обработка завершения
process.once('SIGINT', () => bot.stop('SIGINT'));
process.once('SIGTERM', () => bot.stop('SIGTERM'));
