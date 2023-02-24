#	Cabify Shop

##	About

This project was carried out following the MVVM-C pattern (Model-View-ViewModel with Coordinator), without using third-party libraries.



##	UI

The graphic interface was created using UIKit and developed entirely in code, without intervention of Storyboards or XIBs.

##	Navigation

As mentioned, a coordinator was created to manage the navigation between screens. This avoids charging the ViewController with an extra responsability.

##	View Model

The application has two View Models that are responsible for preparing the necessary information for the view.
The first one, HomeViewModel, is the one that is responsible for calling the different services: ItemsLoader (which loads the items from the server) and DiscountsLoader (which obtains discounts). The other one, CartViewModel, calculates the different values needed for the Cart, the subtotal, the discount, and the total.

##	Netowrking 
As mentioned, ItemsLoader obtains Items from the call to the server. For this there's have a HTTPClient instance which, using URLSession (Apple API for Networking), gets the corresponding endpoint information. This data is decoded by ItemsMapper, which transforms JSON data into Item type elements, to be used by the application.

##	About the Discounts 
The discounts were developed following the possibility of adding new ones in the future. To do this, they conform to a Discount interface, which defines the "apply(cart:)" method, to apply that discount to the cart.
Then, as many versions of discounts can be implemented as desired. In this case, two: XForYDiscount was implemented, which can be used for all discounts of type 2x1, 3x2, etc., and BulkDiscount, which offers item discounts when a minimum bulk of that product is carried.

As clarification, it's possible to use the same networking dependency used for the Items (HTTPClient) to obtain discounts, if at some point it is desired to load them externally. The only thing that should be modified is that the Mapper that should be used would be a potential DiscountsMapper.

## Testing

For testing, unit tests were performed on the system logic: services used, networking and view models.

## Considerations

- Discounts are hard-coded for easier and faster use. As mentioned this could be obtained from a server or a static JSON file with simple adjustements.
- Discounts are modeled in a way that they only apply to a single product. They have an itemCode property wich matched the code property of an Item.
- The purchased is erased when comming back from Cart. Although this is not a real-world expected experience is done thinking in trying different purchases without rebuilding the app. 
- Items are not saved anywhere. This elements are retrieved from the server as requested in the first screen, but they are not saved in any cache or persistance mechanism. 
