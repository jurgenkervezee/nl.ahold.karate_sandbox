Feature: Test different Jsons

Scenario Test Json1
    Given def cat =
    """
      {
        name: 'Billie',
        kittens: [
          { id: 23, name: 'Bob'  },
          { id: 42, name: 'Wild' }
        ]
      }
    """

#Then def expected = [{ id: 42, name: 'Wild' }, { id: 23, name: 'Bob' }]
#And  print expected
#And  match cat == { name: 'Billie', kittens: '#(^^expected)' }
Then match cat.kittens[*].id contains 23
Then match cat.kittens[*].id contains [42]
Then match cat.kittens[*].id contains [23, 42]
Then match cat.kittens[*].id contains any  [42, 23, 99]




Scenario: Test Json2
Given def json  =
"""
{
"packaging": [
    {
        "batch_id": "142-HB1-1384-20190110",
        "item_is_packaging": 0,
        "divi_code": "HB1",
        "orlo_no": 1384,
        "orde_no": 88176301,
        "orde_packaging_no": 5,
        "packaging_code": "DS",
        "packaging_description": "Klapkrat"
    }
  ]
}
"""
#And print json.packaging
Then match json.packaging[0] contains { batch_id : "142-HB1-1384-20190110", divi_code: "HB1" }
And match json.packaging[0] contains { packaging_code: 'DS' }


Scenario: Test Json3
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

   Then match json.store.book[*] contains [{"category":"reference","author":"Nigel Rees","title":"Sayings of the Century","price":8.95},{"category":"fiction","author":"Evelyn Waugh","title":"Sword of Honour","price":12.99},{"category":"fiction","author":"Herman Melville","title":"Moby Dick","isbn":"0-553-21311-3","price":8.99},{"category":"fiction","author":"J. R. R. Tolkien","title":"The Lord of the Rings","isbn":"0-395-19395-8","price":22.99}]
   Then match json.store.book[*] contains {"category":"reference","author":"Nigel Rees","title":"Sayings of the Century","price":8.95}
   Then match json.store.book[*].author contains "Nigel Rees"

#   Itereer over een array and check global contents
   Then match each json.store.book  == { category: '#present', author: '#string', title: '#string', isbn: '#ignore', price: '#number' }

#   geef aan hoeveel entries in the array hebt
  Then match json.store.book.length() == 4

#  Check dat een boek met een ISBN nummer een auteur J. R. R. Tolkien heeft
  Then match json.store.book[?(@.isbn)].author contains "J. R. R. Tolkien"

#   Select the prices of the book under 10 and check the values
  Then match json.store.book[?(@.price < 10)].price == [8.95 , 8.99]

#'##[_ > 10]'

  Scenario: Test Json4
    Given def json =
"""
{   "order_status":
          [
            {
            "order_no":15008262,
            "order_status":"Cancelled"
            },
            {
            "order_no":17620222,
            "order_status":"Active"
            }
          ]
}

"""
    Then print json.order_status[0]
    Then match json.order_status[0].order_no == 15008262
    Then match json.order_status[0].order_status == "Cancelled"
    Then match json.order_status[*] contains {"order_no":17620222,"order_status":"Active"}
#    Then match json.order_status[1].order_status == "Cancelled"
#    Then match json.order_status[?(@.order_no =='#[$.count]'] == 2