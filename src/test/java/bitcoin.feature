Feature: Bitcoin data API

  Background:
    * configure logPrettyResponse = true
    * def generateJsonFile =
    """
    function(response) {
     var jsonPath = 'top5coinprice' + '.json';
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
    Given url "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum%2Cripple%2Clitecoin&vs_currencies=inr"
    When method get
    Then status 200
    * generateJsonFile(response)