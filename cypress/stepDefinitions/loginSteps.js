import { Given, When, Then } from '@badeball/cypress-cucumber-preprocessor'
Given('I navigate to automation exercise website', () => {
	cy.visit('https://automationexercise.com/')
})
When('I enter login credentials {string} {string}', (user, pass) => {
    cy.get('a[href="/login"]').click()
    cy.contains('Login to your account').should('be.visible')
    cy.get('input[data-qa="login-email"]').type(user)
    cy.get('input[data-qa="login-password"]').type(pass)
    cy.get('button[data-qa="login-button"]').click()
})

Then('I should be logged in', () => {
    cy.contains('Logged in as ').should('be.visible')
})

Then('I should see the error message {string}', (errorMessage) => {
    cy.contains(errorMessage).should('be.visible')
})