Feature: Create response from external file
  As a api client developer
  In order to keep TuTu configuration as small as possible
  I need to load response content from external file using {% include %}

  Scenario: Create response from request parameters
    Given there is a responses config file "responses.yml" with following content:
    """
    hello_world:
      path: /hello/world
      content: @resources/hello_world.twig.html
    """
    And there is a resource file "hello_world.twig.html" with following content
    """
    Hello {{ request.request.get('name') }}!
    """
    And TuTu is running on host "localhost" at port "8000"
    When http client send POST request on "http://localhost:8000/hello/world" with following parameters:
      | Parameter | Value   |
      | name      | Norbert |
    Then response status code should be 200
    And the response content should be equal to:
    """
    Hello Norbert!
    """