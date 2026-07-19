package model;
public class CartItem {
    private int cartItemId, cartId, menuId, quantity, restaurantId;
    private String itemName;
    private double price;
    public CartItem() {}
    public CartItem(int cartItemId, int cartId, int menuId, int quantity) {
        this.cartItemId = cartItemId; this.cartId = cartId;
        this.menuId = menuId; this.quantity = quantity;
    }
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
}