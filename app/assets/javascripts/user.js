$(function(){

  function appendProduct(user){
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>`
    $("#user-search-result").append(html);
  }

  // 検索フォームに文字が入力されるたびに発火
  $("#user-search-field").on("keyup", function(){
    var input = $("#user-search-field").val();

    // 入力された情報をコントローラへ
    $.ajax({
      url: "/users",
      type: "GET",
      data: { keyword: input },
      dataType: 'json',
    })

    // 成功した場合の処理
    .done(function(users){
      $("#user-search-result").empty();
      if(users.length !== 0 ){
        users.forEach(function(user){
          appendProduct(user);
        });
      }
      else{
        $("#user-search-result").append("一致するメンバーはいません");
      }
    })
    // 失敗した場合の処理
    .fail(function(){
      alert("ユーザー検索に失敗しました")
    })
  })
})



$(function(){

  function add_user_HTML(new_member){
    // オブジェクトの属性値を取得して表示
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${new_member.attr("data-user-id")}'>
                  <p class='chat-group-user__name'>${new_member.attr("data-user-name")}</p>
                  <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
                </div>`
    return html
  }

  // 追加をクリックしたら発火
  $(document).on("click", ".chat-group-user__btn--add", function(){

    
    

    // $new_memberにクリックした場所のオブジェクトを代入
    var new_member = $(this);
    // 追加したuserの名前を消す
    $(new_member.parent()).remove();
    // 追加したらフォームの中を空にする
    $('form')[0].reset();

    var add_user_html = add_user_HTML(new_member);
    $('#chat-group-users').append(add_user_html)
  })

  // 削除をクリックしたら発火
  $(document).on("click", ".js-remove-btn", function(){
    $delete_member = $(this);
    $delete_member.parent().remove();
  })
})
