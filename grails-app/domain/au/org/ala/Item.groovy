package au.org.ala

class Item {
    long id
    int categoryId
    long spcode
    String name

    static constraints = {
        name(blank:false)
    }
}
