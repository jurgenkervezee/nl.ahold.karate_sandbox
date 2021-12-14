Feature: Demo voor Oelan

  Background:
    *  url 'https://jsonplaceholder.typicode.com'

# Path en Assertions
  Scenario: Getting User 1
    Given path '/users/1'
    When method get
    Then status 200



















# verschillende assertions
  Scenario: simple test met assertion
    Given url 'https://jsonplaceholder.typicode.com/todos/1'
    When method get
    Then status 200





  Scenario: simple test and a following extra call
    Given path 'todos'
    When method get
    Then status 200
    And print response[0].userId








  Scenario Outline: Making Loads of calls

    Given path 'todos/'
    When method get
    Then status 200
    And match response.title


    Examples:
      | id | title                                | completed|
      | 1  | 'delectus aut autem'                 | false    |



#  Helper Features
  Scenario: helper_klasse
    Given path 'todos/1'
    When method get
    Then status 200

#   ingewikkeldere Assertions / Fuzzy assertions


#   commandline aftrappen








  Scenario: Photo's
    Given path 'photos/1'
    When method get
    Then status 200
    And def id = response.id
    And print id



  Scenario: Jsonpath jur
    Given def json =
"""
{
    "store": {
        "book": [
            {
                "category": "reference",
                "author": "Nigel Rees",
                "title": "Sayings of the Century",
                "price": 8.95
            },
            {
                "category": "fiction",
                "author": "Evelyn Waugh",
                "title": "Sword of Honour",
                "price": 12.99
            },
            {
                "category": "fiction",
                "author": "Herman Melville",
                "title": "Moby Dick",
                "isbn": "0-553-21311-3",
                "price": 8.99
            },
            {
                "category": "fiction",
                "author": "J. R. R. Tolkien",
                "title": "The Lord of the Rings",
                "isbn": "0-395-19395-8",
                "price": 22.99
            }
        ],
        "bicycle": {
            "color": "red",
            "price": 19.95
        }
    },
    "expensive": 10
}

"""

    Then match json.store.book[2].title == "Moby Dicek"



  Scenario: XML kan ook
    Given def cat = <cat><name>Billie</name></cat>
    * set cat /cat/name = 'Jean'
    * match cat / == <cat><name>Jean</name></cat>


# you can even set whole fragments of xml
    * def xml = <foo><bar>baz</bar></foo>
    * set xml/foo/bar = <hello>world</hello>
    * match xml == <foo><bar><hello>world</hello></bar></foo>

  Scenario: Nog een XML voorbeeld
    Given def foo =
  """
  <records>
    <record index="1">a</record>
    <record index="2">b</record>
    <record index="3" foo="bar">c</record>
  </records>
  """

    * match foo count(/records//record) == 3
    * match foo //record[@index=2] == 'b'
    * match foo //record[@foo='bar'] == 'c'