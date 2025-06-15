import { Markup } from 'telegraf';
import { hasLevel } from '../utils/adminUtils.js';

export default bot =>
  bot.start(async ctx => {
    if (!(await hasLevel(ctx.from.id, 1)))
      return ctx.reply('🚫 Нет доступа.');

    ctx.reply(
      '👋 Главное меню:',
      Markup.keyboard([
        ['📊 Онлайн', '💾 Собеседования'],
        ['🛠 Админ‑панель']
      ]).resize()
    );
  });
