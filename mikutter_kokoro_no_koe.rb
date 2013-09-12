# -*- coding: utf-8 -*-
# このプラグインはmikutter_suddenly_death(https://github.com/Akkiesoft/mikutter_suddenly_death)をインスパイアしたものです

Plugin.create(:mikutter_kokoro_no_koe) do
  command(:you_thinks,
    name: '心の声',
    condition: lambda{ |opt| true },
    visible: true,
    role: :postbox
  ) do |opt|
    begin
      message = Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text
      message = "。○（#{message}）"
      Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text = message
      
      if UserConfig[:you_thinks_immediate] then
        Post.primary_service.update(:message => message)
        Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text = ""
      else
        Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text = message
      end
    end
  end
  settings "心の声" do
    boolean('すぐに投稿する', :you_thinks_immediate)
  end
end
