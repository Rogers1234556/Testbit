import { Telegraf, Markup } from 'telegraf';
import fetch from 'node-fetch';
import fs from 'fs/promises';
import dotenv from 'dotenv';
import sqlite3 from 'sqlite3';
import { open } from 'sqlite';
dotenv.config();

const ADMINS_FILE = './admins.json';
let db;

// Загружаем админов из JSON
async function loadAdmins() {
  try {
    const data = await fs.readFile(ADMINS_FILE, 'utf8');
    const json = JSON.parse(data);
    return json && Array.isArray(json.admins) ? json : { admins: [] };
  } catch {
    return { admins: [] };
  }
}

async function saveAdmins(data) {
  await fs.writeFile(ADMINS_FILE, JSON.stringify(data, null, 2));
}

async function getAdminLevel(userId) {
  const data = await loadAdmins();
  const admin = data.admins.find(a => a.id === userId);
  return admin ? admin.level : 0;
}

async function hasLevel(userId, level) {
  return (await getAdminLevel(userId)) >= level;
}

async function addAdmin(id, level, nickname = '') {
  const data = await loadAdmins();
  if (data.admins.find(a => a.id === id)) return false;
  data.admins.push({ id, level, nickname });
  await saveAdmins(data);
  return true;
}

async function addZam(id, nickname) {
  const data = await loadAdmins();
  if (data.admins.find(a => a.id === id)) return false;
  data.admins.push({ id, level: 1, nickname });
  await saveAdmins(data);
  return true;
}

async function delAdmin(id) {
  const data = await loadAdmins();
  const beforeLen = data.admins.length;
  data.admins = data.admins.filter(a => a.id !== id);
  if (data.admins.length === beforeLen) return false;
  await saveAdmins(data);
  return true;
}

const bot = new Telegraf(process.env.BOT_TOKEN);

const userStates = new Map();
const userInSupport = new Set();
const bannedUsers = new Map();
const userSupportMessages = new Map(); // userId → messageId

const SUPPORT_GROUP_ID = -1002868859843;

// Инициализация базы для подписки
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

const cancelSupportKeyboard = Markup.keyboard([
  ['❌ Отменить вызов поддержки']
]).resize();

// Клавиатура всегда снизу
const mainKeyboard = Markup.keyboard([
  ['🧩 Активацию', '📦 Скачать'],
  ['💬 Поддержка']
]).resize();

// Команда /start
bot.start((ctx) => {
  ctx.reply(
    '👋 Вас приветствует команда S | R\n\nМы разрабатываем дополнения для комфортной игры, и вы можете приобрести плагин, или обратиться в поддержку прямо здесь.',
    mainKeyboard
  );
});

// Обработка кнопки "Активацию"
bot.hears('🧩 Активацию', (ctx) => {
  ctx.reply(
    'Выберите товар:',
    Markup.inlineKeyboard([
      [Markup.button.callback('🧩 SRm', 'select_srm')]
    ])
  );
});

// Обработка выбора SRm
bot.action('select_srm', async (ctx) => {
  await ctx.answerCbQuery(); // убираем "часики" Telegram
  ctx.editMessageText(
    'Вы выбрали SRm.\n\nСтоимость: ⭐250 навсегда, и ⭐50 на месяц.',
    Markup.inlineKeyboard([
      [Markup.button.callback('💳 Оплатить', 'pay_srm')],
      [Markup.button.callback('🔙 Назад', 'back_to_products')]
    ])
  );
});

// Оплата
bot.action('pay_srm', async (ctx) => {
  await ctx.answerCbQuery();
  ctx.editMessageText('💳 Платежная система скоро будет добавлена. Свяжитесь с поддержкой.');
});

// Назад
bot.action('back_to_products', async (ctx) => {
  await ctx.answerCbQuery();
  ctx.editMessageText(
    'Выберите товар:',
    Markup.inlineKeyboard([
      [Markup.button.callback('🧩 SRm', 'select_srm')]
    ])
  );
});

// Остальные кнопки
bot.hears('📦 Скачать', (ctx) => {
  ctx.reply('⬇️ Ссылка на скачивание будет предоставлена после активации.');
});

// Поддержка
bot.hears('💬 Поддержка', (ctx) => {
  userInSupport.add(ctx.from.id);
  ctx.reply(
    'Здравствуйте!\n\nНапишите Ваш вопрос, и мы ответим Вам в ближайшее время.',
    cancelSupportKeyboard
  );
});

// Нажал «Отменить вызов поддержки»
bot.hears('❌ Отменить вызов поддержки', async (ctx) => {
  const userId = ctx.from.id;
  userInSupport.delete(userId);

  const msgId = userSupportMessages.get(userId);

  if (msgId) {
    try {
      await bot.telegram.editMessageText(
        SUPPORT_GROUP_ID,
        msgId,
        undefined,
        `📩 Вопрос от @${ctx.from.username || 'БезUsername'} (ID: ${userId}):\n${ctx.message.text}\n\n🧠 Вопрос был закрыт`
      );
    } catch (e) {
      console.log('Не удалось отредактировать сообщение:', e.message);
    }

    userSupportMessages.delete(userId);
  }

  ctx.reply('🛑 Вызов поддержки отменён.', {
    reply_markup: mainKeyboard.reply_markup,
  });
});

bot.command('adddev', async ctx => {
  if (!(await hasLevel(ctx.from.id, 3))) return ctx.reply('🚫 Нет доступа.');
  const args = ctx.message.text.split(' ');
  if (args.length < 2) return ctx.reply('Использование: /accept ID');
  const userId = Number(args[1]);
  if (isNaN(userId)) return ctx.reply('ID должен быть числом.');
  const added = await addAdmin(userId, 3);
  ctx.reply(added ? `✅ Доступ выдан пользователю ${userId}` : '❌ Пользователь уже есть в списке.');
});

bot.command('addadm', async ctx => {
  if (!(await hasLevel(ctx.from.id, 3))) return ctx.reply('🚫 Нет доступа.');
  const args = ctx.message.text.split(' ');
  if (args.length < 3) return ctx.reply('Использование: /addzam ID Nickname');
  const userId = Number(args[1]);
  const nickname = args.slice(2).join(' ');
  if (isNaN(userId)) return ctx.reply('ID должен быть числом.');
  const added = await addZam(userId, nickname);
  ctx.reply(added ? `✅ Заместитель ${nickname} добавлен` : '❌ Уже в списке.');
});

bot.command('admins', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
  const data = await loadAdmins();
  if (data.admins.length === 0) return ctx.reply('Список пуст.');
  let list = '👥 <b>Список заместителей и админов:</b>\n\n';
  data.admins.forEach(a => {
    list += `• ID: <code>${a.id}</code> | Ник: ${a.nickname || 'неизвестно'} | Уровень: ${a.level}\n`;
  });
  ctx.replyWithHTML(list);
});

bot.command('deladm', async ctx => {
  if (!(await hasLevel(ctx.from.id, 3))) return ctx.reply('🚫 Нет доступа.');
  const args = ctx.message.text.split(' ');
  if (args.length < 2) return ctx.reply('Использование: /del ID');
  const userId = Number(args[1]);
  if (isNaN(userId)) return ctx.reply('ID должен быть числом.');
  const deleted = await delAdmin(userId);
  ctx.reply(deleted ? `✅ Доступ пользователя ${userId} удалён.` : '❌ Пользователь не найден.');
});

async function fetchOnlineData() {
  const res = await fetch('http://launcher.hassle-games.com:3000/online.json');
  return await res.json();
}

function generateOnlineText(crmp) {
  let total = 0;
  let text = `S | R » Онлайн проекта "<a href="https://t.me/hassleonline"><b>RADMIR CR:MP</b></a>"\n\n`;
  for (const [id, server] of Object.entries(crmp)) {
    const sid = id.toString().padStart(2, '0');
    const players = server.players || 0;
    const bonus = server.bonus || 1;
    total += players;
    text += `${sid}. "<a href="https://t.me/hassleonline">SERVER ${sid}</a> <b>[x${bonus}]</b>", онлайн: <b>${players}</b>\n`;
  }
  text += `\n— Суммарный онлайн: <b>${total}</b>`;
  return text;
}

bot.command('online', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
  try {
    const data = await fetchOnlineData();
    const crmp = data.crmp_new;
    const message = generateOnlineText(crmp);
    await ctx.reply(message, {
      parse_mode: 'HTML',
      disable_web_page_preview: true
    });
  } catch (e) {
    console.error(e);
    ctx.reply('❌ Не удалось получить онлайн.');
  }
});

bot.command('sub', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
  try {
    await db.run('INSERT OR IGNORE INTO subscribers (user_id) VALUES (?)', [ctx.from.id]);
    ctx.reply('✅ Вы подписались на уведомления о стримах Мараса Шакира!');
  } catch (err) {
    ctx.reply('❌ Ошибка при подписке.');
  }
});

bot.command('unsub', async ctx => {
  if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
  try {
    await db.run('DELETE FROM subscribers WHERE user_id = ?', [ctx.from.id]);
    ctx.reply('❎ Вы отписались от уведомлений.');
  } catch (err) {
    ctx.reply('❌ Ошибка при отписке.');
  }
});

async function notifyAll(message) {
  const subscribers = await db.all('SELECT user_id FROM subscribers');
  for (const user of subscribers) {
    bot.telegram.sendMessage(user.user_id, message).catch(() => {});
  }
}

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
      }
    }
  } catch (err) {
    console.error('Ошибка при проверке стрима:', err.message);
  }
}

setInterval(checkLiveStream, 2 * 60 * 1000);

// 📤 Пользователь пишет сообщение → отправляется в группу
// Ответ менеджера в группе → отправка в ЛС пользователя
bot.on('message', (ctx) => {
  const user = ctx.from;
  const text = ctx.message.text;

  // Если пользователь в режиме поддержки
  if (userInSupport.has(user.id) && text && ctx.chat.type === 'private') {
    bot.telegram.sendMessage(
      SUPPORT_GROUP_ID,
      `📩 Вопрос от @${user.username || 'БезUsername'} (ID: ${user.id}):\n${text}`
    ).then((sentMessage) => {
      userSupportMessages.set(user.id, sentMessage.message_id);
    });
  }

  // 📥 Ответ менеджера в группе (реплай на сообщение с ID)
  if (ctx.chat.id === SUPPORT_GROUP_ID && ctx.message.reply_to_message) {
    const replyText = ctx.message.reply_to_message.text;
    const match = replyText?.match(/ID: (\d+)/);
    const response = ctx.message.text;

    if (match && response) {
      const targetUserId = Number(match[1]);
      bot.telegram.sendMessage(
        targetUserId,
        `📨 Ответ поддержки:\n\n${response}`
      );
    }
  }
});


bot.launch();
console.log('🤖 Бот запущен!');
