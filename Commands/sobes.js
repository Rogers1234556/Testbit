import { hasLevel } from '../utils/adminUtils.js';

export default bot =>
  bot.hears('💾 Собеседования', async ctx => {
    if (!(await hasLevel(ctx.from.id, 1))) return;
    ctx.reply('📌 Последнее собеседование: нет данных');
  });
