# Online Marketplace 
Shopify Summer 2019 Developer Intern Challenge Question 
This webserver is built on Rails 4.0.6 and Ruby 2.3.0. The server is developed using test driven develpment with rpsec.

## Getting Started
Assuming you have the correct Ruby version installed:
1. Fork this github repo and go to the application's main directory
2. Install the required gems by running the bundler

        $  bundle _1.3.0_ install
Note: a higher version of the bundler might not work, just in case, use the bundler at version 1.3.0

3. Start the web server:

        $ rails server

The server is now started at `http://localhost:3000` and you will be able to call the API following the below documentation.

## Online Marketplace API Documentation
### Populating the database
Before demo-ing the server, you can populate the database with products beforehand using the Factory method.
For example, to populate the databse with 20 starting products:       
        
        $ rails console
        $ irb(main):001:0> :001 > 20.times { FactoryBot.create :product }

**Index Product**
----
  Returns json data about all products.

* **URL**

  /products

* **Method:**

  `GET`
  
*  **Data Params**

   **Optional:**
   `only_available_inventory=[boolean]` 
   Only returns product with available inventory

* **Success Response:**

  * **Code:** 200 <br />
    **Content Example:** 
    ```
    [{
        "id": 1,
        "title": "GPS Side Kit",
        "price": "32.3050109226105",
        "inventory_count": 36,
        "created_at": "2019-01-21T01:18:24.415Z",
        "updated_at": "2019-01-21T01:18:24.415Z"
    },
    {
        "id": 2,
        "title": "Side Air Controller",
        "price": "99.788498048564",
        "inventory_count": 13,
        "created_at": "2019-01-21T01:18:24.436Z",
        "updated_at": "2019-01-21T01:18:24.436Z"
    }]
    ```
 
* **Sample cURL Call:**

  ```curl -X GET \
  http://localhost:3000/products \
  -H 'Postman-Token: 1db89552-486d-4f5a-b900-ee4eee15f8f2' \
  -H 'cache-control: no-cache'```
  
**Show Product**
----
  Returns json data about single product.

* **URL**

  /products/:id

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**
   `id:integer` 
   Specified product id to return

* **Success Response:**

  * **Code:** 200 <br />
    **Content Example:** 
    ```
    {
        "id": 4,
        "title": "Output Adapter",
        "price": "12.0376702137771",
        "inventory_count": 9,
        "created_at": "2019-01-21T01:18:24.450Z",
        "updated_at": "2019-01-21T01:18:24.450Z"
    }
    ```
 
* **Sample cURL Call:**

  ```
  curl -X GET \
  http://localhost:3000/products/4 \
  -H 'Postman-Token: c0d8b72b-83b0-4c29-9065-49061c6d121e' \
  -H 'cache-control: no-cache'
  ```
  
 **Create Product**
----
  Create a single product using a json format request
  
* **URL**

  /products

* **Method:**

  `POST`
  
*  **JSON Body**

   **Required Example Value:**
   
   ```
   {
	"product":
	{
	  "title": "Vaccum",
	  "price": 4.5,
	  "inventory_count": 3
	}
   }
   ```
   JSON product object

* **Success Response:**

  * **Code:** 201 <br />
    **Content Example:** 
    ```
    {
        "id": 21,
        "title": "Vaccum",
        "price": "4.5",
        "inventory_count": 3,
        "created_at": "2019-01-21T02:10:33.382Z",
        "updated_at": "2019-01-21T02:10:33.382Z"
    }
    ```
    
  * **Error Response:**

  * **Code:** 422 Unprocessable Entity <br />
    **Example Content:**
    ```
    {
        "errors": {
            "price": [
                "is not a number"
            ]
        }
    }
    ```
 
* **Sample cURL Call:**

  ```
  curl -X POST \
  http://localhost:3000/products \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 843f9081-918a-4d10-8c8a-9352edc3ad85' \
  -H 'cache-control: no-cache' \
  -d '{
	"product":
	{
	  "title": "Vaccum",
	  "price": 4.5,
	  "inventory_count": 3
	}
  }'```
  
**Purchase Product**
----
  Purchase a single product
  
* **URL**

  /products

* **Method:**

  `PUT`
  `PATCH`
  
*  **Data Params**

   **Required:**
   `purchase=true` 
   Specify update product for purchase


* **Success Response:**

  * **Code:** 200 <br />
    **Content Example:** 
    ```
    {
        "id": 1,
        "title": "GPS Side Kit",
        "price": "32.3050109226105",
        "inventory_count": 35,
        "created_at": "2019-01-21T01:18:24.415Z",
        "updated_at": "2019-01-21T02:24:10.852Z"
    }
    ```
    
  * **Error Response:**

  * **Code:** 422 Unprocessable Entity <br />
    **Example Content:**
    ```
    {
    "errors": "Cannot purchase product with 0 inventory count"
    }
    ```
 
* **Sample cURL Call:**

  ```
  curl -X PUT \
  'http://localhost:3000/products/1?purchase=true' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 51489d1d-9370-4325-ae89-5c33dcd54307' \
  -H 'cache-control: no-cache'```
  
**Delete Product**
----
  Destroy a single product specified by id
  
* **URL**

  /products/:id

* **Method:**

  `DELETE`
  
*  **URL Params**

   **Required:**
   `id:integer` 
   Specified product id to destroy


* **Success Response:**

  * **Code:** 204 <br />
    
* **Sample cURL Call:**

  ```
  curl -X GET \
  http://localhost:3000/products \
  -H 'Postman-Token: 351c1018-612c-4eec-b9fc-d095f17ac24e' \
  -H 'cache-control: no-cache'```
  
  
  
