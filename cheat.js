import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { Markup } from 'telegraf';

// Эмуляция __dirname в ES-модуле
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Загрузка данных
const cheatDataPath = path.join(__dirname, 'cheats', 'data.json');
const cheatData = JSON.parse(fs.readFileSync(cheatDataPath, 'utf8'));

// Экспортируем основную функцию
export function setupCheats(bot, hasLevel) {
  bot.command('cheats', async ctx => {
    if (!(await hasLevel(ctx.from.id, 1))) {
      return ctx.reply('🚫 Нет доступа.');
    }

    try {
      const buttons = cheatData.map(cheat =>
        [Markup.button.callback(cheat.name, `cheat_${cheat.id}`)]
      );

      await ctx.reply('📁 Выберите файл:', Markup.inlineKeyboard(buttons));
    } catch (err) {
      console.error('Ошибка при выполнении команды /cheats:', err);
      ctx.reply('❌ Произошла ошибка при выполнении команды.');
    }
  });

  // Обработка callback кнопки
  bot.on('callback_query', async ctx => {
    const data = ctx.callbackQuery.data;
    if (!data.startsWith('cheat_') && !data.startsWith('download_')) return;

    if (data.startsWith('download_')) {
      const cheatId = data.replace('download_', '');
      const cheat = cheatData.find(c => c.id === cheatId);
      if (!cheat) return ctx.answerCbQuery('❌ Файл не найден');

      const filePath = path.join(__dirname, 'cheats', 'files', cheat.file);
      if (!fs.existsSync(filePath)) {
        return ctx.reply('❌ Файл отсутствует на сервере.');
      }

      const stats = fs.statSync(filePath);
      if (stats.size === 0) {
        return ctx.reply('❌ Файл пустой.');
      }

      await ctx.replyWithDocument({ source: fs.createReadStream(filePath), filename: cheat.file });
      return ctx.answerCbQuery('📦 Отправлено!');
    }

    // Клик по читу
    const cheatId = data.replace('cheat_', '');
    const cheat = cheatData.find(c => c.id === cheatId);
    if (!cheat) return ctx.answerCbQuery('❌ Не найдено');

    const imagePath = path.join(__dirname, 'cheats', 'images', cheat.image);
    if (!fs.existsSync(imagePath)) {
      return ctx.reply('❌ Изображение не найдено.');
    }

    const downloadBtn = Markup.inlineKeyboard([
      [Markup.button.callback('📥 Скачать', `download_${cheat.id}`)]
    ]);

    await ctx.replyWithPhoto(
      { source: fs.createReadStream(imagePath) },
      {
        caption: `📌 <b>${cheat.name}</b>\n\n${cheat.description}`,
        parse_mode: 'HTML',
        reply_markup: downloadBtn.reply_markup
      }
    );

    ctx.answerCbQuery();
  });
}
