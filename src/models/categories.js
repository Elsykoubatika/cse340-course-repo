
import db from './db.js';

const getAllCategories = async () => {
    const query = `
        SELECT
            category_id,
            name,
            description,
            image_filename,
            image_alt,
            icon,
            css_class
        FROM public.category
        ORDER BY category_id;
    `;

    const result = await db.query(query);
    return result.rows;
};

export { getAllCategories };
