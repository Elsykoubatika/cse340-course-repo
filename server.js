import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { getAllOrganizations } from './src/models/organizations.js';
import dotenv from 'dotenv' ;
dotenv.config();

import { testConnection } from './src/models/db.js';

dotenv.config();

const app = express();
const port = process.env.PORT || 5500;
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


// Middleware and view engine configuration
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));

// Home route
app.get('/', async (req, res) => {
  const title = 'Home';
  res.render('home', { title });
});

// Organizations route
app.get('/organizations', async (req, res) => {
  const title = 'Our Partner Organizations';
  res.render('organizations', { title });
});

// Service projects route
app.get('/projects', async (req, res) => {
  const title = 'Service Projects';
  res.render('projects', { title });
});

// Categories route
app.get('/categories', async (req, res) => {
  const title = 'Service Project Categories';
  res.render('categories', { title });
});

// 404 route
app.use((req, res) => {
  const title = 'Page Not Found';
  res.status(404).render('404', { title });
});

//app.listen(port, () => {
// console.log(`CSE 340 Service Network running at http://localhost:${port}`);
//});
const PORT = process.env.PORT || 5500;
const NODE_ENV = process.env.NODE_ENV || 'development';
app.listen(PORT, async () => {
    try {
        await testConnection();

        console.log(`CSE 340 Service Network running at http://localhost:${port}`);
        console.log(`Environment: ${NODE_ENV}`);
    } catch (error) {
        console.error('Error connecting to the database:', error);
    }
});

app.get('/organizations', async (req, res) => {
    const organizations = await getAllOrganizations();
    console.log(organizations);
      
    const title = 'Our Partner Organizations';
    res.render('organizations', { title });
});