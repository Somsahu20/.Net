<%@ Page Title="WebForm1" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Ecommerce.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
        .product-image {
            height: 250px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .price-tag {
            font-size: 1.25rem;
            font-weight: 600;
        }
        .stock-badge {
            font-size: 0.85rem;
        }
        .category-filter {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            color: white;
        }
        .page-header {
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    

    <div class="container-fluid px-4">
       
        <div class="category-filter">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <h5 class="mb-md-0 mb-2">
                        <i class="fas fa-filter me-2"></i>Filter Products
                    </h5>
                </div>
                <div class="col-md-9">
                    <asp:DropDownList ID="ddlCategory" runat="server" 
                        CssClass="form-select form-select-lg" 
                        AutoPostBack="true" 
                        OnSelectedIndexChanged="selectIndex">
                        <asp:ListItem Value="0" Text=" All Categories" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text=" Lower-garments"></asp:ListItem>
                        <asp:ListItem Value="2" Text=" Footwear"></asp:ListItem>
                        <asp:ListItem Value="3" Text=" UpperBody-Garments"></asp:ListItem>
                        <asp:ListItem Value="4" Text=" Headwear"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

      
        <div class="row g-4">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
                        <div class="card product-card h-100 border-0 shadow-sm">
                            <div class="position-relative overflow-hidden">
                                <img class="card-img-top product-image" 
                                     src='<%# Eval("ImageURL") %>' 
                                     alt='<%# Eval("Name") %>' 
                                     onerror="this.src='/images/no-image.jpg'" />
                                
                              
                                <div class="position-absolute top-0 start-0 m-3">
                                    <span class="badge bg-success stock-badge">
                                         Stock: <%# Eval("Stock") %>
                                    </span>
                                </div>
                            </div>
                            
                            <div class="card-body d-flex flex-column">
                              
                                <h5 class="card-title text-primary fw-bold mb-2">
                                    <%# Eval("Name") %>
                                </h5>
                                
                                
                                <p class="card-text text-muted flex-grow-1 small lh-sm">
                                    <%# Eval("Description") %>
                                </p>
                                
                             
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="price-tag text-success">
                                        ₹ <%# Eval("Price") %>
                                    </span>
                                </div>
                                
                            
                                <div class="mt-3">
                                    <asp:Button ID="btnAddToCart" runat="server" 
                                        Text="Add to Cart" 
                                        CssClass="btn btn-primary w-100 fw-bold"
                                        CommandArgument='<%# Eval("Id") %>' 
                                        CommandName="AddToCart"
                                        OnCommand="AddToCart"
                                        />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
  
  
        <asp:Panel ID="pnlNoProducts" runat="server" Visible="false">
            <div class="text-center py-5">
                <div class="alert alert-info border-0 shadow-sm" style="max-width: 500px; margin: 0 auto;">
                    <div class="mb-3">
                        <i class="fas fa-search fa-3x text-muted"></i>
                    </div>
                    <h4 class="alert-heading">No Products Found</h4>
                    <p class="mb-0">There are currently no products available in this category. Please try selecting a different category.</p>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>