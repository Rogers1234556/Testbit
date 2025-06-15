import { Markup } from 'telegraf';
import { getAdminLevel, hasLevel, loadAdmins } from '../utils/adminUtils.js';

export default bot => {
  bot.hears('🛠 Админ‑панель', async ctx => {
    const userId = ctx.from.id;
    const level = await getAdminLevel(userId);
    if (level === 0) return ctx.reply('🚫 Нет доступа.');

    const rows = [];
    if (level >= 1) rows.push([Markup.button.callback('📊 Онлайн', 'online')]);
    if (level >= 2) rows.push([Markup.button.callback('➕ +Зам.', 'addzam')]);
    if (level >= 3) {
      rows.push([
        Markup.button.callback('➕ +Адм.', 'addadm'),
        Markup.button.callback('➖ Убрать адм', 'deladm')
      ]);
      rows.push([Markup.button.callback('📋 Список', 'list_admins')]);
    }

    ctx.reply('🛠 Админ‑панель:', Markup.inlineKeyboard(rows));
  });

  bot.action('addzam', ctx => {
    ctx.reply('✏️ Чтобы выдать заместителя:\n/addzam <ID> <nickname>');
    ctx.answerCbQuery();
  });

  bot.action('addadm', ctx => {
    ctx.reply('✏️ Чтобы выдать администратора:\n/addadm <ID> <2|3>');
    ctx.answerCbQuery();
  });

  bot.action('deladm', ctx => {
    ctx.reply('✏️ Чтобы снять доступ:\n/deladm <ID>');
    ctx.answerCbQuery();
  });

  bot.action('list_admins', async ctx => {
    const userId = ctx.from.id;
    if (!(await hasLevel(userId, 3))) return ctx.answerCbQuery('Нет доступа');

    const admins = await loadAdmins();
    const lines = admins.map(a =>
      `• <code>${a.id}</code> (${a.tag || 'неизвестно'}) — уровень ${a.level}`
    ).join('\n');

    ctx.editMessageText(`👤 <b>Список админов:</b>\n\n${lines}`, { parse_mode: 'HTML' });
  });
};
