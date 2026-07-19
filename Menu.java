package model;

public class Menu {
    private int menuId, restaurantId;
    private String itemName, description, category, imageUrl;
    private double price;
    private boolean available, veg;

    public Menu() {}
    public Menu(int menuId, int restaurantId, String itemName, String description,
                double price, String category, boolean veg, String imageUrl, boolean available) {
        this.menuId = menuId; this.restaurantId = restaurantId; this.itemName = itemName;
        this.description = description; this.price = price; this.category = category;
        this.veg = veg; this.imageUrl = imageUrl; this.available = available;
    }

    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public boolean isVeg() { return veg; }
    public void setVeg(boolean veg) { this.veg = veg; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }
}