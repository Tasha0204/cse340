import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';
import { testConnection } from './src/models/db.js';
import { getAllOrganizations } from './src/models/organizations.js';
import { getAllProjects } from './src/models/projects.js';
import { getAllCategories } from './src/models/categories.js';


const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';


const PORT = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();


app.use(express.static(path.join(__dirname, 'public')));


app.set('view engine', 'ejs');


app.set('views', path.join(__dirname, 'src/views'));
app.use((req, res, next) => {
    if (NODE_ENV === 'development') {
        console.log(`${req.method} ${req.url}`);
    }
    next();
});
app.use((req, res, next) => {
    res.locals.NODE_ENV = NODE_ENV;
    next();
});



/**
 * Routes
 */
app.get('/', async (req, res) => {
    const title = 'Home';
    res.render('home', { title });
});

app.get('/organizations', async (req, res) => {

    try {

        const organizations = await getAllOrganizations();
        const title = 'Our Partner Organizations';

        res.render('organizations', { title, organizations });
    } catch (error) {
        console.error('Error al obtener las organizaciones:', error);
        res.status(500).send('Error interno del servidor');
    }
});

app.get('/projects', async (req, res) => {
    const projects = await getAllProjects();
    const title = 'Service Projects';

    res.render('projects', { title, projects });
});

app.get('/categories', async (req, res) => {
    const categories = await getAllCategories();
    const title = 'Service Project Categories';

    res.render('categories', { title, categories });
});
// Test route for 500 errors
app.get('/test-error', (req, res, next) => {
    const err = new Error('This is a test error');
    err.status = 500;
    next(err);
});
// Catch-all route for 404 errors
app.use((req, res, next) => {
    const err = new Error('Page Not Found');
    err.status = 404;
    next(err);
});

// Global error handler
app.use((err, req, res, next) => {
    console.error('Error occurred:', err.message);
    console.error('Stack trace:', err.stack);

    const status = err.status || 500;
    const template = status === 404 ? '404' : '500';

    const context = {
        title: status === 404 ? 'Page Not Found' : 'Server Error',
        error: err.message,
        stack: err.stack
    };


    res.status(status).render(`errors/${template}`, context);
});



app.listen(PORT, async () => {
    try {
        await testConnection();
        console.log(`Server is running at http://127.0.0.1:${PORT}`);
        console.log(`Environment: ${NODE_ENV}`);
    }
    catch (error) {
        console.error('Failed to connect to the database:', error);
        process.exit(1);
    }
});