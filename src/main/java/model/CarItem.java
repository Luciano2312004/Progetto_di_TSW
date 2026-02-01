package model;
import java.io.Serializable;
import java.util.List;
public class CarItem implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id;
    private String name;
    private String model;
    private String image;
    private double basePrice;
    private double totalPrice;
    private int qty;
    private int year; // ADDED: Year field for DB persistence
    // Dettagli configurazione (aggiornati)
    private Option selectedColor;
    private Option selectedInteriorColor;
    private Option wheel;
    private List<Option> packages;
    private List<Option> accessories;
    private Option autopilot;
    // Costruttore vuoto
    public CarItem() {}
    // --- GETTER E SETTER ---
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getModel() {
        return model;
    }
    public void setModel(String model) {
        this.model = model;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public double getBasePrice() {
        return basePrice;
    }
    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }
    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    public int getQty() {
        return qty;
    }
    public void setQty(int qty) {
        this.qty = qty;
    }
    public int getYear() {
        return year;
    }
    public void setYear(int year) {
        this.year = year;
    }
    public Option getSelectedColor() {
        return selectedColor;
    }
    public void setSelectedColor(Option selectedColor) {
        this.selectedColor = selectedColor;
    }
    public Option getSelectedInteriorColor() {
        return selectedInteriorColor;
    }
    public void setSelectedInteriorColor(Option selectedInteriorColor) {
        this.selectedInteriorColor = selectedInteriorColor;
    }
    public Option getWheel() {
        return wheel;
    }
    public void setWheel(Option wheel) {
        this.wheel = wheel;
    }
    public List<Option> getPackages() {
        return packages;
    }
    public void setPackages(List<Option> packages) {
        this.packages = packages;
    }
    public List<Option> getAccessories() {
        return accessories;
    }
    public void setAccessories(List<Option> accessories) {
        this.accessories = accessories;
    }
    public Option getAutopilot() {
        return autopilot;
    }
    public void setAutopilot(Option autopilot) {
        this.autopilot = autopilot;
    }
}