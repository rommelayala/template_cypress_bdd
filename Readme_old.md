cypress


cypress DBB
https://blog.emumba.com/getting-started-with-cypress-10-and-cucumber-6b43ff68633b
1.- npm init -y
    
    package name: (cy-bdd-tests) cypress-template
    version: (1.0.0)
    description: Exercises using cypress
    entry point: (index.js)
    test command:
    git repository:
    keywords: BDD, cucucmber, cypress
    author: Rommel
    license: (ISC)

2.- npm i cypress@10.11.0 --save-dev

3.- 
    - Add this line to package.json
        {
        "name": "cypress-template",
        "version": "1.0.0",
        "description": "Exercises using cypress ",
        "main": "index.js",
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1",
    ----->  "cypress:open": "cypress open"

        },
        "keywords": [
            "BDD",
            "cucucmber",
            "cypress"
        ],
        "author": "Rommel",
        "license": "ISC"
        }
    3,1 - execute 
        npx cypress open 
        and click on e2e, continue and close the window

4.- (BDD) Installing cucumber
    npm i @badeball/cypress-cucumber-preprocessor
    npm i cypress @bahmutov/cypress-esbuild-preprocessor esbuild

5.- (BDD) Configure cypress.config.js (esta en el root de la app)
    
    const createBundler = require('@bahmutov/cypress-esbuild-preprocessor')
const addCucumberPreprocessorPlugin =
	require('@badeball/cypress-cucumber-preprocessor').addCucumberPreprocessorPlugin
const createEsBuildPlugin =
	require('@badeball/cypress-cucumber-preprocessor/esbuild').createEsbuildPlugin


const { defineConfig } = require('cypress')
require('dotenv').config();

module.exports = defineConfig({
	e2e: {
		async setupNodeEvents(on, config) {
			// implement node event listeners here
			const bundler = createBundler({
				plugins: [createEsBuildPlugin(config)],
			})
			on('file:preprocessor', bundler)
			await addCucumberPreprocessorPlugin(on, config)
			return config
		},
		specPattern: 'cypress/e2e/features/*.feature',
	},
})


6.- (BDD) create new file in the root of directory called .cypress-cucumber-preprocessorrc.json
    {
        "stepDefinitions": [
        "cypress/stepDefinitions/*.js"
        ]
    }

7.- Write cypress/e2e/features/login.feature

Feature: Login
Scenario: Login user with correct email and password
Given I navigate to automation exercise website
When I enter login credentials
Then I should be logged in

8.- write the code in cypress/stepDefinitions/loginSteps.js

import { Given, When, Then } from '@badeball/cypress-cucumber-preprocessor'
Given('I navigate to automation exercise website', () => {
	cy.visit('https://automationexercise.com/')
})
When('I enter login credentials', () => {
	cy.get('a[href="/login"]').click()
	cy.contains('Login to your account').should('be.visible')
	cy.get('input[data-qa="login-email"]').type('example1@test.com')
	cy.get('input[data-qa="login-password"]').type('foobar')
	cy.get('button[data-qa="login-button"]').click()
})
Then('I should be logged in', () => {
	cy.contains('Logged in as ').should('be.visible')
})



Resources:

https://automationexercise.com/

Examples:
https://www.linkedin.com/pulse/cypress-end-testing-automatizaci%C3%B3n-de-pruebas-extremo-n%C3%A9stor-alonso/?originalSubdomain=es




