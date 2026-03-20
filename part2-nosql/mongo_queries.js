// Connect to database (assuming already selected DB: use ecommerce)
const collection = db.products;


// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
  "_id": "elec_1001",
  "name": "Samsung 55-inch 4K Smart TV",
  "category": "Electronics",
  "brand": "Samsung",
  "price": 64999,
   "specifications": {
    "screen_size": "55 inches",
    "resolution": "3840x2160",
    "display_type": "LED",
    "smart_tv": true,
    "connectivity": ["WiFi", "Bluetooth", "HDMI", "USB"]
  },
  "warranty": {
    "period": "2 years",
    "type": "Manufacturer"
  },
  "ratings": {
    "average": 4.5
  },
  "seller": {
    "name": "Reliance Digital"
  }
},

{
  "_id": "cloth_2001",
  "brand": "Allen Solly",
  "price": 1499,
  "currency": "INR",
  "stock": 120,
  "attributes": {
    "material": "Cotton",
    "fit": "Slim Fit",
    "pattern": "Solid",
    "sleeve_type": "Full Sleeve",
    "gender": "Men"
  },
  "sizes_available": ["S", "M", "L", "XL"],
  "color_variants": [
    { "color": "Blue", "stock": 40 },
    { "color": "White", "stock": 30 },
    { "color": "Black", "stock": 50 }
  ],
  "care_instructions": [
    "Machine wash cold",
    "Do not bleach",
    "Iron at low temperature"
  ]
},

{
  "_id": "groc_3001",
  "name": "Organic Toor Dal 1kg",
  "category": "Groceries",
  "brand": "TATA Samppan",
  "price": 210,
  "currency": "INR",
  "packaging": {
    "weight": "1 kg",
    "type": "Pouch"
  },
  "expiry_details": {
    "manufacture_date": "2026-01-15",
    "expiry_date": "2027-01-14",
    "shelf_life_days": 365
  },
  "nutritional_info": {
    "per_100g": {
      "energy_kcal": 343,
      "protein_g": 22,
      "carbohydrates_g": 63,
      "fat_g": 1.7,
      "fiber_g": 15
    }
  }
}
]);


// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});


// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  "expiry_details.expiry_date": { $lt: new Date("2025-01-01") }
});


// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "elec_1001" },
  { $set: { discount_percent: 10 } }
);


// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });

/*
Why this index?
- Improves performance of queries filtering by category (very common in e-commerce)
- Speeds up OP2 and OP3 significantly
- Reduces full collection scans (better scalability as data grows)
*/