$: << ENV['AKKA_HOME']

require 'java'

require 'jl1.0.1.jar'
java_import 'javazoom.jl.player.Player';
java_import 'java.io.BufferedInputStream';
java_import 'java.io.FileInputStream';

module Music
  def play_mp3(file)
    fis     = FileInputStream.new(file);
    bis = BufferedInputStream.new(fis);
    player = Player.new(bis);
    player.play
    player.close
  end
end
