Feature: get all coins data

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
  Scenario: get all coins
    Given url "https://api.coingecko.com/api/v3/coins/list"
    When method get
    Then status 200
    * generateJsonFile("allcoins",response)

  @getbtc
    Scenario: get all coins market data
      Given url "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h"
      When method get
      Then status 200
      * generateJsonFile("allcoins_marketdata",response)

