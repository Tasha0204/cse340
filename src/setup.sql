-- ========================================
-- Organization Table
-- ========================================

CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================

INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders',
'A nonprofit focused on improving community infrastructure through sustainable construction projects.',
'info@brightfuturebuilders.org',
'brightfuture-logo.png'),

('GreenHarvest Growers',
'An urban farming collective promoting food sustainability and education in local neighborhoods.',
'contact@greenharvest.org',
'greenharvest-logo.png'),

('UnityServe Volunteers',
'A volunteer coordination group supporting local charities and service initiatives.',
'hello@unityserve.org',
'unityserve-logo.png');


SELECT * FROM organization;


-- ========================================
-- Service Project Table
-- ========================================
CREATE TABLE IF NOT EXISTS service_project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT fk_organization FOREIGN KEY (organization_id)
        REFERENCES organization (organization_id)
        ON DELETE CASCADE
);

-- ========================================
-- Insert sample data: Service Projects
-- ========================================
INSERT INTO service_project (organization_id, title, description, location, date)
VALUES
-- BrightFuture Builders
(1,
'Community Center Paint Day',
'Painting and refreshing the local youth center walls.',
'Community Hall A',
'2026-04-10'),

(1,
'Park Cleanup Initiative',
'Cleaning up trash and planting flowers at Central Park.',
'Central Park South',
'2026-04-18'),

(1,
'Youth Mentorship Workshop',
'Hosting a study skills workshop for middle schoolers.',
'Public Library Room 3',
'2026-05-02'),

(1,
'Food Drive Sorting',
'Sorting and packing donated canned goods for local families.',
'Community Warehouse',
'2026-05-15'),

(1,
'Tree Planting Event',
'Planting native trees along the neighborhood walking paths.',
'Greenway Trail',
'2026-05-28'),

-- GreenHarvest Growers
(2,
'Urban Garden Build',
'Constructing raised garden beds for the community greenhouse.',
'Northside Plot',
'2026-04-12'),

(2,
'Composting 101 Seminar',
'Teaching residents basic backyard composting techniques.',
'Eco Center',
'2026-04-20'),

(2,
'Harvest Gleaning',
'Collecting surplus produce from local farms for food banks.',
'Valley Farmlands',
'2026-05-05'),

(2,
'Seedling Distribution',
'Distributing free organic vegetable seedlings to the public.',
'Farmers Market Square',
'2026-05-18'),

(2,
'School Garden Workshop',
'Helping children plant herbs and vegetables at the local school.',
'Elementary Courtyard',
'2026-06-01'),

-- UnityServe Volunteers
(3,
'Senior Tech Support',
'Helping older adults learn how to use smartphones and computers.',
'Senior Community Center',
'2026-04-14'),

(3,
'Warm Meal Delivery',
'Preparing and delivering hot meals to homebound residents.',
'City Kitchen',
'2026-04-22'),

(3,
'Winter Clothing Sorting',
'Sorting donated coats and blankets ahead of the colder months.',
'Charity Donation Center',
'2026-05-08'),

(3,
'Blood Drive Assistance',
'Welcoming donors and managing the refreshment station.',
'Red Cross Hall',
'2026-05-20'),

(3,
'Charity Run Logistics',
'Directing runners and handing out water at the annual charity marathon.',
'Downtown Avenue',
'2026-06-05');





-- ========================================
-- category Table
-- ========================================

CREATE TABLE IF NOT EXISTS public.category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.service_project_category (
    project_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project 
        FOREIGN KEY (project_id) 
        REFERENCES public.service_project (project_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_category 
        FOREIGN KEY (category_id) 
        REFERENCES public.category (category_id) 
        ON DELETE CASCADE
);
Select*from category;

--inserting categories 
INSERT INTO public.category (name) VALUES 
('Environment'),
('Education'),
('Community Support');

Select*from category;

-- link the previously created projects to the category table

INSERT INTO public.service_project_category (project_id, category_id)
 VALUES 
(1, 3), 
(2, 1), 
(3, 2), 
(4, 3), 
(5, 1), 

(6, 1), 
(7, 2), 
(8, 3),
(9, 2),
(10, 1),

(11, 3),
(12, 2),
(13, 1),
(14, 3),
(15, 2);
