 @PruebaMarvel
Feature: Evaluación Desarrolladores Marvel

Background:
        * def base_url = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/cgipiale/api/characters'
        * header content-type = 'application/json'
        * configure ssl = true
        
    @id:1 @ConsultarPersonaje
    Scenario: T-API-BTFAC-123-CA01- Consultar Personajes
        Given url base_url
        When method GET
        Then status 200
        And print response  

    @id:2 @ConsultarPersonajePorID
    Scenario: T-API-BTFAC-123-CA02- Consultar Por ID
        Given url base_url + '/1'
        When method GET
        Then status 200
        And print response  

     @id:3 @ConsultarPersonajePorIDNoExiste
    Scenario: T-API-BTFAC-123-CA03- Consultar Por ID No existe
        Given url base_url + '/100'
        When method GET
        Then status 404
        And print response  
           
      @id:4 @AgregarSuperHeroe
      Scenario: T-API-BTFAC-123-CA04- Agregar Personaje
          Given url base_url
          And def ingreso = read('classpath:../payloads/SuperHeroe.json')
          And request ingreso
          When method POST
          Then status 201
          And print response

      @id:5 @AgregarSuperHeroeDuplicado
      Scenario: T-API-BTFAC-123-CA04- Agregar Personaje
          Given url base_url
          And def ingreso = read('classpath:../payloads/SuperHeroe.json')
          And request ingreso
          When method POST
          Then status 400
          And print response

    @id:6 @EliminaPersonajePorID
    Scenario: T-API-BTFAC-123-CA06- Eliminar un Personaje Por ID
        * def personaje = call read('karate-test.feature@ConsultarPersonajePorID')
        * print personaje
        * def personajeId = personaje.response.id
        Given url base_url + '/' + personajeId
        When method DELETE
        Then status 204
        * print response

       @id:7 @AgregarSuperHeroeCamposFaltantes
      Scenario: T-API-BTFAC-123-CA04- Agregar Personaje Campos Faltantes
          Given url base_url
          And def ingreso = read('classpath:../payloads/SuperHeroeFaltante.json')
          And request ingreso
          When method POST
          Then status 400
          And print response
	
	@id:8 @EliminaPersonajeNo existe
    Scenario: T-API-BTFAC-123-CA06- Eliminar un Personaje No existe

        * def personajeId = 500
        Given url base_url + '/' + personajeId
        When method DELETE
        Then status 404
        * print response
		
	@id:9 @ActualizarPersonaje
    Scenario: Actualizar Personaje
        * def characterId = 9
        Given url base_url + '/' + characterId
        And def character = read('classpath:../payloads/updateCharacter.json')
        And request character
        When method PUT
        Then status 200
        And print response
        And assert response.id == characterId
		
		           
  @id:10 @ActualizarPersonajeNoExiste
    Scenario: Actualizar Personaje No Existente
        * def characterId = 999
        Given url base_url + '/' + characterId
        And def character = read('classpath:../payloads/updateCharacter.json')
        And request character
        When method PUT
        Then status 404
        And print response
        And assert response.error == "Character not found"

		
       
       



 