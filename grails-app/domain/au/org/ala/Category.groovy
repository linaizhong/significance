package au.org.ala

class Category {
    int id
    String name

    static hasMany = [items: Item]

    static constraints = {
        name(blank:false)
    }
}
