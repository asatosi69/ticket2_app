$(function() {

  // チェックボックスをチェックしたら発動
  $('input[name="invalid_flag"]').change(function() {

    // もしチェックが入ったら
    if ($(this).prop('checked')) {

      // 固定値を出力
      $('#status').text('true');

    } else {

      // 固定値を出力
      $('#status').text('false');
    }

  });
});
