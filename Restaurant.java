package model;

public class Restaurant {
    private int restaurantId;
    private String name, address, cuisineType, imageUrl, deliveryTime, priceForTwo;
    private double rating;

    public Restaurant() {}
    public Restaurant(int restaurantId, String name, String address, String cuisineType,
                       double rating, String deliveryTime, String priceForTwo, String imageUrl) {
        this.restaurantId = restaurantId; this.name = name; this.address = address;
        this.cuisineType = cuisineType; this.rating = rating;
        this.deliveryTime = deliveryTime; this.priceForTwo = priceForTwo; this.imageUrl = imageUrl;
    }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    public String getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(String deliveryTime) { this.deliveryTime = deliveryTime; }
    public String getPriceForTwo() { return priceForTwo; }
    public void setPriceForTwo(String priceForTwo) { this.priceForTwo = priceForTwo; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}