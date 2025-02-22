#!/bin/bash

# Create project folder structure
mkdir -p backend frontend admin database .github/workflows cypress/integration cypress/support

# Backend structure
mkdir -p backend/{config,controllers,models,routes,middleware,utils,tests}
touch backend/{server.js,package.json,.env.example}
touch backend/tests/{sample.test.js}

# Frontend structure
mkdir -p frontend/{components,pages,styles,utils,public,tests}
touch frontend/{package.json,.env.example}
touch frontend/tests/{sample.test.js}

# Admin panel structure
mkdir -p admin/{config,database}
touch admin/package.json

# Database folder
mkdir -p database
touch database/seed.js

# Cypress E2E testing setup
mkdir -p cypress/integration
mkdir -p cypress/support

touch cypress/integration/sample.spec.js

echo "describe('Homepage Test', () => {
  it('should load the homepage', () => {
    cy.visit('/');
    cy.contains('Welcome to Afaaq Mobile').should('be.visible');
  });
});" > cypress/integration/sample.spec.js

touch cypress/support/commands.js

echo "import './commands';" > cypress/support/index.js

touch cypress.json

echo "{
  \"baseUrl\": \"http://localhost:3000\",
  \"viewportWidth\": 1280,
  \"viewportHeight\": 720
}" > cypress.json

# GitHub Actions workflow folder
mkdir -p .github/workflows
touch .github/workflows/deploy.yml

# Create GitHub Actions CI/CD Workflow for Vercel, Railway, Jest, and Cypress E2E Testing
echo "name: Deploy to Vercel and Railway with Jest and Cypress Testing

on:
  push:
    branches:
      - main

jobs:
  test-backend:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v16
        with:
          node-version: 16
          cache: 'npm'

      - name: Install backend dependencies
        run: |
          cd backend
          npm install

      - name: Run Jest tests for backend
        run: |
          cd backend
          npm test

  test-frontend:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v16
        with:
          node-version: 16
          cache: 'npm'

      - name: Install frontend dependencies
        run: |
          cd frontend
          npm install

      - name: Run Jest tests for frontend
        run: |
          cd frontend
          npm test

  test-e2e:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v16
        with:
          node-version: 16
          cache: 'npm'

      - name: Install Cypress dependencies
        run: |
          npm install cypress --save-dev

      - name: Run Cypress tests
        run: |
          npx cypress run

  deploy-backend:
    runs-on: ubuntu-latest
    needs: [test-backend, test-frontend, test-e2e]
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Deploy Backend to Railway
        run: curl -X POST -H \"Content-Type: application/json\" -d '{}' ${{ secrets.RAILWAY_DEPLOY_HOOK }}

  deploy-frontend:
    runs-on: ubuntu-latest
    needs: [test-backend, test-frontend, test-e2e]
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Deploy Frontend to Vercel
        run: curl -X POST -H \"Authorization: Bearer ${{ secrets.VERCEL_DEPLOY_HOOK }}\" https://api.vercel.com/v1/integrations/deploy/${{ secrets.VERCEL_PROJECT_ID }}" > .github/workflows/deploy.yml

# Root files
touch {.gitignore,LICENSE,README.md,package.json,docker-compose.yml}

# Add and commit changes to the existing GitHub repository
git add .
git commit -m "Initial project structure setup with CI/CD, Jest Testing, and Cypress E2E Testing"
git push origin main

echo "Project structure successfully updated and pushed to GitHub with GitHub Actions CI/CD, Jest Testing, and Cypress E2E Testing."
