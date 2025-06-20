@PruebaMarvel
Feature: Evaluación Desarrolladores Marvel

Background:
        * def base_url = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
        * header content-type = 'application/json'
        * configure ssl = true
        
    @id:1 @ConsultarPersonajes
    Scenario: T-API-BTFAC-123-CA01- Consultar Personajes
        Given url base_url
        When method GET
        Then status 200
        And print response  
        And match response.status == 'available'    