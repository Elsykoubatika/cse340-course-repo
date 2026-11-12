

-- ========================================
-- ORGANIZATION TABLE
-- ========================================

CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL,
    image_filename VARCHAR(255) NOT NULL
);


-- ========================================
-- ORGANIZATION SAMPLE DATA
-- ========================================

INSERT INTO organization (
    name,
    description,
    contact_email,
    logo_filename,
    image_filename
)
VALUES
(
    'BrightFuture Builders',
    'A nonprofit focused on improving community infrastructure through sustainable construction projects.',
    'info@brightfuturebuilders.org',
    'brightfuture.svg',
    'reading-support.png'
),
(
    'GreenHarvest Growers',
    'An urban farming collective promoting food sustainability and education in local neighborhoods.',
    'contact@greenharvest.org',
    'greenharvest.svg',
    'green-harvest-garden.png'
),
(
    'UnityServe Volunteers',
    'A volunteer coordination group supporting local charities and service initiatives.',
    'hello@unityserve.org',
    'unityserve.svg',
    'community-service.png'
);


-- ========================================
-- PROJECT TABLE
-- Organization and image are optional.
-- ========================================

CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER
        REFERENCES organization(organization_id)
        ON DELETE SET NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    image_filename VARCHAR(255)
);


-- ========================================
-- PROJECT SAMPLE DATA
-- ========================================

INSERT INTO project (
    organization_id,
    name,
    description,
    image_filename
)
VALUES
(
    (SELECT organization_id FROM organization
     WHERE name = 'BrightFuture Builders'),
    'Reading Support Program',
    'Provides educational resources and reading support to young people.',
    'reading-support.png'
),
(
    (SELECT organization_id FROM organization
     WHERE name = 'GreenHarvest Growers'),
    'Urban Community Garden',
    'Develops community gardens and promotes sustainable food production.',
    'green-harvest-garden.png'
),
(
    (SELECT organization_id FROM organization
     WHERE name = 'UnityServe Volunteers'),
    'Neighborhood Clean-Up',
    'Organizes volunteers to clean and improve local neighborhoods.',
    'neighborhood-clean-up.png'
),
(
    NULL,
    'Community Food Delivery',
    'Coordinates food deliveries for families and people in need.',
    'community-food-driver.png'
),
(
    NULL,
    'Health and Wellness Outreach',
    'Promotes community health and wellness through outreach activities.',
    'health-and-wellness.png'
),
(
    (SELECT organization_id FROM organization
     WHERE name = 'UnityServe Volunteers'),
    'Home Volunteer Support',
    'Connects volunteers with households that need practical assistance.',
    'home-volunteers.png'
);


-- ========================================
-- CATEGORY TABLE
-- ========================================


-- ========================================
-- CATEGORY TABLE
-- ========================================

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    image_filename VARCHAR(255) NOT NULL,
    image_alt TEXT NOT NULL,
    icon VARCHAR(20) NOT NULL,
    css_class VARCHAR(80) NOT NULL
);


-- ========================================
-- CATEGORY SAMPLE DATA
-- ========================================

INSERT INTO category (
    name,
    description,
    image_filename,
    image_alt,
    icon,
    css_class
)
VALUES
(
    'Environmental',
    'Protect natural spaces, reduce waste, and support a healthier environment.',
    'neighborhood-clean-up.png',
    'Green forest and natural landscape',
    '🌱',
    'category-environmental'
),
(
    'Educational',
    'Encourage learning through tutoring, mentoring, and educational activities.',
    'reading-support.png',
    'Students learning together in a classroom',
    '📚',
    'category-educational'
),
(
    'Community Service',
    'Support neighbors and strengthen the places where people live.',
    'community-service.png',
    'Community volunteers working together',
    '🤝',
    'category-community'
),
(
    'Health and Wellness',
    'Promote well-being, healthy habits, and access to helpful resources.',
    'health-and-wellness.png',
    'Person practicing mindfulness outdoors',
    '💚',
    'category-health'
);


-- ========================================
-- PROJECT_CATEGORY TABLE
-- Many-to-Many relationship
-- ========================================

CREATE TABLE project_category (
    project_id INTEGER NOT NULL
        REFERENCES project(project_id)
        ON DELETE CASCADE,

    category_id INTEGER NOT NULL
        REFERENCES category(category_id)
        ON DELETE CASCADE,

    PRIMARY KEY (project_id, category_id)
);


-- ========================================
-- ASSOCIATE PROJECTS WITH CATEGORIES
-- Every project has at least one category.
-- ========================================

WITH category_assignments(project_name, category_name) AS (
    SELECT 'Reading Support Program', 'Educational'
    UNION ALL SELECT 'Urban Community Garden', 'Environmental'
    UNION ALL SELECT 'Urban Community Garden', 'Community Service'
    UNION ALL SELECT 'Neighborhood Clean-Up', 'Environmental'
    UNION ALL SELECT 'Neighborhood Clean-Up', 'Community Service'
    UNION ALL SELECT 'Community Food Delivery', 'Community Service'
    UNION ALL SELECT 'Health and Wellness Outreach', 'Health and Wellness'
    UNION ALL SELECT 'Home Volunteer Support', 'Community Service'
)
INSERT INTO project_category (project_id, category_id)
SELECT
    p.project_id,
    c.category_id
FROM category_assignments AS ca
JOIN project AS p
    ON p.name = ca.project_name
JOIN category AS c
    ON c.name = ca.category_name;
