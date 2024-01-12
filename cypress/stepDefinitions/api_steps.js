import { Given, When, Then } from '@badeball/cypress-cucumber-preprocessor'

import xml2js from 'xml2js'

let requestBody
let responseStatusCode
let responseBody

Given('I prepare a {string} request to {string}', (method, url) => {
	cy.wrap(method).as('requestMethod')
	cy.wrap(url).as('apiUrl')
})

Given('I use this body:', (body) => {
	requestBody = JSON.parse(body)
	cy.wrap(requestBody).as('requestBody')
})


When('I send the {string} request', (method) => {
	cy.get('@apiUrl').then((url) => {
		cy.get('@requestMethod').then((requestMethod) => {
			if (requestMethod.toLowerCase() === method.toLowerCase()) {
				if (method.toLowerCase() === 'post') {
					cy.request('POST', url, requestBody).as('response')
				} else if (method.toLowerCase() === 'delete') {
					cy.request('DELETE', url, requestBody).as('response')
				} else if (method.toLowerCase() === 'put') {
					cy.request('PUT', url, requestBody).as('response')
				} else if (method.toLowerCase() === 'get') {
					cy.request('GET', url).as('response')
				} else {
					throw new Error(`Unsupported method: ${method}`)
				}
			} else {
				throw new Error(
					`Mismatched request method. Expected: ${method}, Actual: ${requestMethod}`
				)
			}
		})
	})
})

Then('the response status code is {string}', (statusCode) => {
	cy.get('@response').its('status').should('eq', parseInt(statusCode))
})

Then(
	'the response is {string} contains {string}',
	(contentType, expectedString) => {
		cy.get('@response').then((response) => {
			if (contentType.toLowerCase() === 'xml') {
				// Parse XML response
				const parser = new xml2js.Parser({ explicitArray: false })
				parser.parseString(response.body, (err, result) => {
					const xmlResponse = result
					cy.wrap(xmlResponse).should('deep.include', expectedString)
				})
			} else if (contentType.toLowerCase() === 'json') {
				// Parse JSON response
				const jsonResponse = response.body
				cy.wrap(jsonResponse).should(
					'deep.include',
					JSON.parse(expectedString)
				)
			} else {
				throw new Error(`Unsupported content type: ${contentType}`)
			}
		})
	}
)

Given('a pet with id {string} exists', (petId) => {
	cy.request('GET', `http://localhost:8080/api/v3/pet/${petId}`).as(
		'getPetResponse'
	)
	cy.get('@getPetResponse').its('status').should('eq', 200)
})

Given('I add pet id {string} into url', (petId) => {
	const queryParams = { id: petId }
	cy.get('@apiUrl').then((url) => {
		const updatedUrl = `${url}/${petId}`
		cy.wrap(updatedUrl).as('apiUrl')
	})
})
