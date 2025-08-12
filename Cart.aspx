<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Ecommerce.Cart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .cart-header {
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            text-align: center;
            border-radius: 10px;
        }
        
        .cart-item-card {
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 15px;
            border-radius: 10px;
            transition: transform 0.2s ease;
        }
        
        .cart-item-card:hover {
            transform: translateY(-2px);
        }
        
        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            border: 2px solid #007bff;
            background: white;
            color: #007bff;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .quantity-btn:hover {
            background: #007bff;
            color: white;
        }
        
        .quantity-input {
            width: 60px;
            text-align: center;
            border: 2px solid #dee2e6;
            border-radius: 5px;
            padding: 5px;
        }
        
        .price-text {
            font-size: 1.25rem;
            font-weight: 600;
            color: #28a745;
        }
        
        .total-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: #dc3545;
        }
        
        .cart-summary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            position: sticky;
            top: 20px;
        }
        
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .empty-cart i {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        
        .btn-remove {
            background: #dc3545;
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            transition: all 0.2s ease;
        }
        
        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-container">
        <!-- Cart Header -->
        <div class="cart-header">
            <h1 class="mb-2">
                <i class="fas fa-shopping-cart me-3"></i>Your Shopping Cart
            </h1>
            <p class="mb-0">Review your items before checkout</p>
        </div>

        <!-- User Not Logged In Panel -->
        <asp:Panel ID="pnlNotLoggedIn" runat="server" Visible="false">
            <div class="alert alert-warning text-center">
                <h4><i class="fas fa-exclamation-triangle"></i> Please Login</h4>
                <p>You need to be logged in to view your cart.</p>
                <asp:Button ID="btnLogin" runat="server" Text="Go to Login" 
                    CssClass="btn btn-primary" OnClick="btnLogin_Click" />
            </div>
        </asp:Panel>

        <!-- Main Cart Content -->
        <asp:Panel ID="pnlCartContent" runat="server">
            <div class="row">
                
                <div class="col-lg-8">
                   
                    <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                        <ItemTemplate>
                            <div class="card cart-item-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        
                                        <div class="col-md-2 col-sm-3 text-center">
                                            <img src='<%# Eval("ImageURL") %>' alt='<%# Eval("Name") %>' 
                                                 class="product-image" onerror="this.src='/images/no-image.jpg'" />
                                        </div>
                                        
                                       
                                        <div class="col-md-4 col-sm-6">
                                            <h5 class="text-primary fw-bold mb-1"><%# Eval("Name") %></h5>
                                            <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                                            <span class="price-text">₹ <%# Eval("Price") %></span>
                                        </div>
                                        
                                        <!-- Quantity Controls -->
                                        <div class="col-md-3 col-sm-6">
                                            <label class="form-label small">Quantity:</label>
                                            <div class="quantity-controls">
                                                <asp:Button ID="btnDecrease" runat="server" Text="-" 
                                                    CssClass="quantity-btn"
                                                    CommandName="DecreaseQuantity"
                                                    CommandArgument='<%# Eval("CartId") %>' />
                                                    
                                                <asp:TextBox ID="txtQuantity" runat="server" 
                                                    Text='<%# Eval("Quantity") %>'
                                                    CssClass="quantity-input" 
                                                    ReadOnly="true" />
                                                    
                                                <asp:Button ID="btnIncrease" runat="server" Text="+" 
                                                    CssClass="quantity-btn"
                                                    CommandName="IncreaseQuantity"
                                                    CommandArgument='<%# Eval("CartId") %>' />
                                            </div>
                                        </div>
                                        
                                        <!-- Subtotal and Remove -->
                                        <div class="col-md-3 col-sm-6 text-end">
                                            <div class="mb-2">
                                                <strong class="total-text">
                                                    ₹ <%# Convert.ToInt32(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                                                </strong>
                                            </div>
                                            <asp:Button ID="btnRemove" runat="server" Text="Remove" 
                                                CssClass="btn-remove"
                                                CommandName="RemoveItem"
                                                CommandArgument='<%# Eval("CartId") %>'
                                                OnClientClick="return confirm('Are you sure you want to remove this item?');" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    
                    <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                        <div class="empty-cart">
                            <i class="fas fa-shopping-cart text-muted"></i>
                            <h3>Your cart is empty</h3>
                            <p>Looks like you haven't added any items to your cart yet.</p>
                            <asp:Button ID="btnContinueShopping" runat="server" 
                                Text="Continue Shopping" 
                                CssClass="btn btn-primary btn-lg"
                                OnClick="btnContinueShopping_Click" />
                        </div>
                    </asp:Panel>
                </div>


                <div class="col-lg-4">
                    <asp:Panel ID="pnlCartSummary" runat="server">
                        <div class="cart-summary">
                            <h4 class="mb-4">
                                <i class="fas fa-receipt me-2"></i>Order Summary
                            </h4>
                            
                            <div class="d-flex justify-content-between mb-2">
                                <span>Total Items:</span>
                                <strong>
                                    <asp:Label ID="lblTotalItems" runat="server" Text="0"></asp:Label>
                                </strong>
                            </div>
                            
                            <div class="d-flex justify-content-between mb-2">
                                <span>Subtotal:</span>
                                <strong>₹ <asp:Label ID="lblSubtotal" runat="server" Text="0.00"></asp:Label></strong>
                            </div>
                            
                            <div class="d-flex justify-content-between mb-2">
                                <span>Shipping:</span>
                                <strong>₹ <asp:Label ID="lblShipping" runat="server" Text="50.00"></asp:Label></strong>
                            </div>
                            
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tax (5%):</span>
                                <strong>₹ <asp:Label ID="lblTax" runat="server" Text="0.00"></asp:Label></strong>
                            </div>
                            
                            <hr class="bg-white">
                            
                            <div class="d-flex justify-content-between mb-4">
                                <span class="h5">Total:</span>
                                <strong class="h4">₹ <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label></strong>
                            </div>
                            
                            <asp:Button ID="btnCheckout" runat="server" 
                                Text="Proceed to Checkout" 
                                CssClass="btn btn-light btn-lg w-100 fw-bold"
                                OnClick="btnCheckout_Click" />
                                
                            <asp:Button ID="btnContinueShoppingBottom" runat="server" 
                                Text="Continue Shopping" 
                                CssClass="btn btn-outline-light w-100 mt-2"
                                OnClick="btnContinueShopping_Click" />
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
