// File: model/Option.java
package model;

import java.io.Serializable;

public class Option implements Serializable {
    private static final long serialVersionUID = 1L;
    private String name;
    private double price;

    public Option() {}

    public Option(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}