Feature: Bitcoin data API

  Background:
    * configure logPrettyResponse = true
    * def generateJsonFile =
    """
    function(filename,response) {
     var jsonPath = filename + '.json';
     karate.write(response, jsonPath);
     karate.log('saved json to:', jsonPath);
    }
    """

@getbtc
  Scenario: check Geco API status
    Given url "https://api.coingecko.com/api/v3/ping"
    When method get
    Then status 200

  @getbtc
  Scenario: check Geco API status
    Given url "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Cripple%2Clitecoin%2Cmonero&vs_currencies=inr%2Cusd%2Ceur"
    When method get
    Then status 200
    * generateJsonFile("top5coins",response)

