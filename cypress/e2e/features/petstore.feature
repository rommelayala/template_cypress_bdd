Feature: This file contains test all CRUD cicle using petstore web page

    Background:
        #Precondition: Delete petId =10
        Given I prepare a "DELETE" request to "http://localhost:8080/api/v3/pet"
        And I add pet id "10" into url
        And I send the "DELETE" request
        And the response status code is "200"

    Scenario: Create a new pet
        #Precondition: Delete petId =10
        ######### Test scenario
        Given I prepare a "POST" request to "http://localhost:8080/api/v3/pet"
        And I use this body:
            """
            {
                "id": 10,
                "name": "doggie",
                "category": {
                    "id": 1,
                    "name": "Dogs"
                },
                "photoUrls": [
                    "string"
                ],
                "tags": [
                    {
                        "id": 0,
                        "name": "string"
                    }
                ],
                "status": "available"
            }
            """
        When I send the "POST" request
        Then the response status code is "200"
        #Postcondition: clean pet created will be cleaned using background


    Scenario: Modify name of pet using id=10
        # Precondition: Delete petId =10
        # Precondition: Create new petId=10
        Given I prepare a "POST" request to "http://localhost:8080/api/v3/pet"
        And I use this body:
            """
            {
                "id": 10,
                "name": "doggie",
                "category": {
                    "id": 1,
                    "name": "Dogs"
                },
                "photoUrls": [
                    "string"
                ],
                "tags": [
                    {
                        "id": 0,
                        "name": "string"
                    }
                ],
                "status": "available"
            }
            """
        And I send the "POST" request
        And the response status code is "200"
        ######### Test
        And I prepare a "PUT" request to "http://localhost:8080/api/v3/pet"
        And I use this body:
            """
            {
                "id": 10,
                "name": "doggie-max",
                "category": {
                    "id": 1,
                    "name": "Dogs"
                },
                "photoUrls": [
                    "string"
                ],
                "tags": [
                    {
                        "id": 0,
                        "name": "string"
                    }
                ],
                "status": "unavailable"
            }
            """
        When I send the "PUT" request
        Then the response status code is "200"
        #Postcondition: clean pet created will be cleaned using background

    Scenario: Check if pet id=10 exist
        # Precondition: Delete petId =10
        # Precondition: Create new petId=10
        Given I prepare a "POST" request to "http://localhost:8080/api/v3/pet"
        And I use this body:
            """
            {
                "id": 10,
                "name": "doggie",
                "category": {
                    "id": 1,
                    "name": "Dogs"
                },
                "photoUrls": [
                    "string"
                ],
                "tags": [
                    {
                        "id": 0,
                        "name": "string"
                    }
                ],
                "status": "available"
            }
            """
        And I send the "POST" request
        And the response status code is "200"
        ########## Test
        Given I prepare a "GET" request to "http://localhost:8080/api/v3/pet"
        And I add pet id "10" into url
        When I send the "GET" request
        Then the response status code is "200"
        #Postcondition: clean pet created will be cleaned using background

    Scenario: Delete pet id=10
        # Precondition: Delete petId =10
        # Precondition: Create new petId=10
        Given I prepare a "POST" request to "http://localhost:8080/api/v3/pet"
        And I use this body:
            """
            {
                "id": 10,
                "name": "doggie",
                "category": {
                    "id": 1,
                    "name": "Dogs"
                },
                "photoUrls": [
                    "string"
                ],
                "tags": [
                    {
                        "id": 0,
                        "name": "string"
                    }
                ],
                "status": "available"
            }
            """
        And I send the "POST" request
        And the response status code is "200"
        ########## Test
        Given I prepare a "DELETE" request to "http://localhost:8080/api/v3/pet"
        And I add pet id "10" into url
        When I send the "DELETE" request
        Then the response status code is "200"
