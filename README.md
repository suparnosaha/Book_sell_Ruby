<h1>Book Shopping System</h1>
<strong>Purchase books at the snap of your finger</strong>

This is an online <b>Book shopping system</b> built using Ruby on rails

<h3>Layout</h3>

*Home Page* - This is available on the top left corner of the application. The link is available throughout the application and can be used to read the home page as needed.

*Cart* - This is available on the top right corner of the application. This is used to checkout the items present in the cart and finish a transaction. The link is available throughout the application.

<img width="1260" alt="login-page" src="https://media.github.ncsu.edu/user/26505/files/16fee861-ab24-4718-ba5d-6399386432ba">


<h3>SignUp/Login</h3>

To use the *book shopping* application, every customer or user needs to login. New Users can use the *SignUp* link to create an account. The username is unique and used as login credential. Returning users can use *Login* and enter valid *username* and *password* to enter the application.

<img width="1253" alt="signup-page" src="https://media.github.ncsu.edu/user/26505/files/9c7b7e78-246b-4fbb-ab5e-d0f6850533c7">


<h3>Home Page</h3>

*User Profile* - This link is used to view the user profile. The user can edit the details or can delete the account from here. Note that the username cannot be modified after the account creation. If a user is deleted, any activity related to the user is also deleted.

*User Transactions* - The link shows the details of all the transactions made by the current user. Under each transaction, there is an option to *Show this transaction* to view the full details of that particular transaction including the quantity and total price of each item(Book) in the transaction. Note that transactions cannot be edited or deleted while the user exists.

*View all Books* - This gives you the details of all the books present in the *Book Shopping System*. Multiple options are available on this page to help user have a smooth experience.

*Book Reviews* - This takes the user exclusively to see the reviews given for the books. Initially the user will be able to see own reviews. *Show this Review* is used to access additional options for the review.

*Logout* - To LogOut of the current session, the user can use this option. As long as the user is not logging out, the session persists across the browser.


<img width="1262" alt="home-page" src="https://media.github.ncsu.edu/user/26505/files/401d46a4-5866-4f91-b446-38a26559fb76">


<h3>Books</h3>

The books can be accessed from homepage using *View all books*.

*Search by Bookname* - This helps in filtering the books based on the *Bookname*. All the results are available on the same page.

*Search by Author* - This helps in filtering the books based on the *Author Name*.

*Search by Rating* - This helps in filtering the books based on the *Average Rating* available.

*Show this Book* - Used to access additional options for the book. Once accessing this, the user can see all the details of the current book. The option *Add Review* is used to add a rating and description for the review. A user can add multiple reviews for each book.

*Add Book to Cart* - Used to add the book to cart for purchase. After clicking the link, the user would be asked to choose the number of books to purchase and then add the book to cart. If the cart already has the book available, user can *edit* the quantity and update the cart or *remove the item* from the cart.

Note that if the book is out of stock, the user will not be able to access the *Add Book to Cart*. If an item in the cart is out of stock, the item will be removed from the cart and the user will be informed about the same during the transaction. The *price* of book is automatically calculated and displayed to the user based on the number of books purchased.

<img width="1261" alt="books-page" src="https://media.github.ncsu.edu/user/26505/files/ad4e3f7e-22e5-4276-8300-c1f97d6075a0">


<h3>Reviews</h3>

The reviews can be accessed from the homepage using *Book Reviews*

All the reviews written will be shown in this page. 

*Search By Username* - The filter is used to view the reviews given by other users.

*Search By Bookname* - This filter is used to obtain all the reviews given for a particular book.

*My Reviews* - This filter is used to obtain all the reviews given by the particular user who is logged in.

The *current user* has access to *view* all the reviews even the ones not written by the current user. However, the current user will *not* be able to *edit or delete* the reviews written by others.

<img width="1257" alt="reviewspage" src="https://media.github.ncsu.edu/user/26505/files/8875a96c-f6a4-4d84-b1d4-2e2731db6958">


<h3>Cart</h3>

The *cart* is available to be accessed all through the application. A user can modify the contents of the cart using *Show this Book* and *Edit this Item* option present in it. When the user accesses the *Checkout*, the page is redirected to *New Transaction*. It is mandatory for the user to provide *Credit Card, Address and Phone Number* details. Once the *Complete Purchase* is clicked, user is redirected to the transaction status page that tells whether a transaction is successful or not. 

Note that a user cannot modify the transactions. User can only *view* the transactions made by self.

<img width="1258" alt="cart-page" src="https://media.github.ncsu.edu/user/26505/files/a09b79eb-d14c-47ad-b0d8-df6877cc227b">



<h2>Admin</h2>
<h4>Credentials</h4>

**Username: admin** <br>
**Password: admin**

The application is pre-loaded with an *admin* user. The admin has extra privileges. The admin can *view, edit and delete* all the regular *users*. However, the admin *cannot* change the *username and password* for the *admin* (self).

An admin can *add* new books, *edit* the existing books or even *delete* the books. When a book is deleted, all the reviews related to the book are also deleted. To *add* a new book, the admin can go to *View all Books* on the *Home Page*. An option to *New Book* is visible at the bottom of the page that allows admin to create book. All fields are mandatory when *creating* a book and book *name* must be *unique*. The default *average rating* for a book is 0 when created.

All the reviews are *editable* and *deletable* by the admin.

<h3>Testing</h3>

Currently testing for the model and controller of *User* is completed. To run the test cases for the model, you can execute the following commands from the root directory.

```bash
RAILS_ENV=test rails db:migrate
bundle exec rspec
```

<h3>Additional Features</h3>

The application has some additional features. Some of the special ones are mentioned below.

- *Autofill* - When a user profile has non mandatory fields like *Address, Credit Card Number & Phone Number*, the details are automatically populated into the transaction page when a user checkout.
- *Race Condition* - When multiple users are trying to buy the book, books may be oversold than the existing stock. Validations and functionality is implemented to prevent this. If multiple users are trying to buy a book at the same time, the system ensures that the book is not oversold.
- *Cart* - To enable the users to buy multiple copies of a book and different books at the same time, cart functionality is implemented. The user can checkout the books added to the cart at the same time. A user can modify the cart any number of times before the transaction is processed.

<h3>Future Scope</h3>

- Frontend can be improved such as using Bootstrap.
- GitHub actions can be created to continuously deploy the application.
- The application can be deployed on Cloud.
- Test cases are added only for one model and controlled which can be extended over full application.

<h3>Developers</h3>

- Aswin Itha - [Connect with me](https://www.linkedin.com/in/aswin-itha)
- Suparno Saha
- Aditi Vakeel
