import { Telegraf } from 'telegraf';
import fetch from 'node-fetch';
import fs from 'fs/promises';
import dotenv from 'dotenv';
dotenv.config();

const BOT_TOKEN = process.env.BOT_TOKEN || 'твой_токен_здесь';
const ADMINS_FILE = './admins.json';

const bot = new Telegraf(BOT_TOKEN);

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
bot.command('online', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
  try {
    const res = await fetch('http://launcher.hassle-games.com:3000/online.json');
    const data = await res.json();
    const crmp = data.crmp_new;
    let totalPlayers = 0;
    let text = `S | R » Онлайн проекта <a href="https://t.me/hassleonline"><b>"RADMIR CR:MP"</b></a>\n\n`;
    for (const [serverId, serverData] of Object.entries(crmp)) {
      const players = serverData.players || 0;
      const bonus = serverData.bonus || 1;
      totalPlayers += players;
      const sid = serverId.toString().padStart(2, '0');
      text += `${sid}. "<a href="https://t.me/hassleonline">SERVER ${sid}</a> <b>[x${bonus}]</b>", онлайн: <b>${players}</b>\n`;
    }
    text += `\n— Суммарный онлайн: <b>${totalPlayers}</b>`;
    ctx.replyWithHTML(text, { disable_web_page_preview: true });
  } catch {
    ctx.reply('❌ Не удалось получить онлайн.');
  }
});

// Команда: /sobes - заглушка
bot.command('sobes', ctx => {
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

// Запуск бота
bot.launch()
  .then(() => {
    console.log('✅ Бот запущен');
  })
  .catch(err => {
    console.error('Ошибка запуска бота:', err);
    process.exit(1); // аварийный выход
  });

// Слушаем порт для Scalingo
const port = process.env.PORT || 3000;
import http from 'http';

http.createServer((req, res) => {
  res.end('Bot is running');
}).listen(port, () => {
  console.log(`Listening on port ${port}`);
});

// Защита от самозакрытия процесса — простой интервал
setInterval(() => {}, 1000 * 60 * 60);

// Корректное завершение
process.once('SIGINT', () => bot.stop('SIGINT'));
process.once('SIGTERM', () => bot.stop('SIGTERM'));
