$(function(){
  function buildHTML(message){
    image = ( message.image ) ? `<image src=${message.image}>` : " " ;

    var html =  `<div class = chats__chat  data-id = ${message.id}>

                  <div class = chats__chat__upper-info>
                    <div class = chats__chat__upper-info__user-name>
                      ${message.user_name}
                    </div>
                    <div class = chats__chat__upper-info__date>
                      ${message.created_at}
                    </div>
                  </div>

                  <div class = chats__chat__message>
                    <div class = chats__chat__message__text>
                      ${message.text}
                    </div>
                    <div class = chats__chat__message__image>
                      ${image}
                    </div>
                  </div>
                </div>`
    return html;
  }

  // フォームが送信されたら発火
  $(".create_message").on("submit", function(e){
    // フォームを送信するための通信を止める
    e.preventDefault();

    // フォームの情報を取得
    var formData = new FormData(this);
    // フォームの送信先のurlを定義
    var href = window.location.href;

    // ajaxで非同期通信に必要なオプションの設定
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
    })

    .done(function(data){
      var html = buildHTML(data);

      // 初めての投稿と２回目以降の投稿で場合分け
      if(data.messages == 0){
        $('.chats').html(html)
      }else{
        $('.chats').append(html)
      }
      // 投稿メッセージまでスクロール
      $('.chats').animate({scrollTop: $('.chats')[0].scrollHeight}, 'fast');
      // テキストボックスを空に
      $('form')[0].reset()
    })

    .fail(function(){
      alert('送信に失敗しました');
    })

    // 送信後の送信を許可
    .always(() => {
      $(".form__new-message__submit-btn").removeAttr("disabled");
      });
  })


  // 自動更新
  var reloadMessages = function(){
    // 最後のメッセージのIDを取得
    var latest_message_id = $(".chats__chat").last().attr('data-messageID');
    // グループのIDを取得
    var group_id = $(".chats__chat").attr('data-groupID');

    $.ajax({
      url: "/groups/"+ group_id + "/api/messages",
      type: "GET",
      data: { last_id: latest_message_id },
      dataType: "json"
    })

    .done(function(messages){
      //追加するHTMLの入れ物を作る
      var insertHTML = " ";

      // メッセージが追加された時だけ
      if(messages.length !== 0 ){
        //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        $.each(messages, function(index, message){
          var newHTML = buildHTML(message);
          insertHTML += newHTML
        });
        // メッセージを追加
        $('.chats').append(insertHTML)
        // 投稿メッセージまでスクロール
        $('.chats').animate({scrollTop: $('.chats')[0].scrollHeight}, 'fast');
      }
    })

    .fail(function(){
      // alert("自動更新に失敗しました")
    });
  };

  setInterval(reloadMessages, 5000);
});
