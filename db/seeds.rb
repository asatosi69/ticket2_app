Connection.destroy_all
# ステージの処理
stage1 = Stage.find(10)
stage2 = Stage.find(11)

# チケット種別の処理
kind1 = Kind.find(11)
kind2 = Kind.find(14)

#関連付けを追加
stage1.kinds << kind1
stage1.kinds << kind2
stage1.save

stage2.kinds << kind1
stage2.kinds << kind2
stage2.save
