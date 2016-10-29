Deface::Override.new(virtual_path: 'spree/users/show',
  name: 'add_loyalty_points_balance_to_account_page',
  insert_after: "#user-info",
  text: "
    <dl id='loyalty-points-info'>
      <dt><i class='fa fa-star'></i><%= Spree.t(:loyalty_points_balance) %></dt>
      <dd><%= @user.loyalty_points_balance %> <%= "(jafngildir " + equivalent_currency_balance.to_s + " kr.)" %> (<%= link_to Spree.t(:details), spree.loyalty_points_path %>)</dd>
    </dl>
  ")
