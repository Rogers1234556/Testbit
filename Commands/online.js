import fetch from 'node-fetch';
import { hasLevel } from '../utils/adminUtils.js';
import { Markup } from 'telegraf';

export default bot => {
  // По тексту
  bot.hears('📊 Онлайн', async ctx => {
    if (!(await hasLevel(ctx.from.id, 1))) return ctx.reply('🚫 Нет доступа.');
    sendOnline(ctx, false);
  });

  // По кнопке из админ-панели
  bot.action('online', async ctx => {
    if (!(await hasLevel(ctx.from.id, 1))) return ctx.answerCbQuery('🚫 Нет доступа');
    ctx.answerCbQuery();
    sendOnline(ctx, true); // true = edit message
  });

  // Кнопка обновления
  bot.action('refresh_online', async ctx => {
    if (!(await hasLevel(ctx.from.id, 1))) return ctx.answerCbQuery('🚫 Нет доступа');
    ctx.answerCbQuery('🔄 Обновлено');
    sendOnline(ctx, true); // обновить текущее сообщение
  });

  // Основная функция
  async function sendOnline(ctx, edit = false) {
    try {
      const res = await fetch('http://launcher.hassle-games.com:3000/online.json');
      const data = await res.json();
      const crmp = data.crmp_new;

      let totalPlayers = 0;
      let lines = [];

      for (const [id, srv] of Object.entries(crmp)) {
        lines.push(`${id.padStart(2, '0')}`);
      }

      let text = `S | R » Онлайн проекта <a href="https://t.me/hassleonline"><b>"RADMIR CR:MP"</b></a>\n\n`;

      for (const [serverId, serverData] of Object.entries(crmp)) {
        const { players, bonus } = serverData;
        totalPlayers += players;

        const sid = serverId.toString().padStart(2, '0');
        text += `${sid}. "<a href="https://t.me/hassleonline">SERVER ${sid}</a> <b>[x${bonus}]</b>", онлайн: <b>${players}</b>\n`;
      }

      text += `\n— Суммарный онлайн: <b>${totalPlayers}</b>`;

      const keyboard = Markup.inlineKeyboard([
        [Markup.button.callback(' Обновить данные', 'refresh_online')]
      ]);

      if (edit) {
        await ctx.editMessageText(text, {
          parse_mode: 'HTML',
          disable_web_page_preview: true,
          reply_markup: keyboard.reply_markup
        });
      } else {
        await ctx.reply(text, {
          parse_mode: 'HTML',
          disable_web_page_preview: true,
          reply_markup: keyboard.reply_markup
        });
      }
    } catch (err) {
      console.error('Ошибка получения онлайна:', err);
    }
  }
};
