from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
import uvicorn

app = FastAPI()

class User(BaseModel):
    id: int
    name: str
    email: str

class Product(BaseModel):
    id: int
    name: str
    price: float

users = [
    User(id=1, name="John Doe", email="john@example.com"),
    User(id=2, name="Jane Doe", email="jane@example.com"),
]

products = [
    Product(id=1, name="Product 1", price=10.99),
    Product(id=2, name="Product 2", price=9.99),
]

@app.get("/users/")
def read_users():
    return users

@app.get("/users/{user_id}")
def read_user(user_id: int):
    for user in users:
        if user.id == user_id:
            return user
    raise HTTPException(status_code=404, detail="User not found")

@app.post("/users/")
def create_user(user: User):
    users.append(user)
    return user

@app.get("/products/")
def read_products():
    return products

@app.get("/products/{product_id}")
def read_product(product_id: int):
    for product in products:
        if product.id == product_id:
            return product
    raise HTTPException(status_code=404, detail="Product not found")

@app.post("/products/")
def create_product(product: Product):
    products.append(product)
    return product

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)