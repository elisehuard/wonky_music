require 'akka'
require 'musician'

class Conductor < Akka::UntypedActor
  def self.spawn
    actor = Akka::Actors.actor_of { new }
    actor.set_dispatcher(Akka::Dispatchers.newThreadBasedDispatcher(actor))
    actor.start
  end

  def onReceive(msg)
    puts "Conductor received #{msg}"
    case msg
    when "go"
      puts "Conductor says: OK, let's play"
      play_guitar
      play_drum
      play_bass 
    when "done guitar"
      play_guitar
    when "done drumming"
      play_end_drum
    else
      puts "msg: #{msg}"
    end
  end

  def play_end_drum
    puts "Conductor says: play end drum"
    end_drum = EndDrum.spawn
    end_drum.send_one_way("play", context)
  end

  def play_drum
    puts "Conductor says: play drum"
    drum = Drum.spawn
    drum.send_one_way("play", context)
  end

  def play_guitar
    puts "Conductor says: play guitar"
    guitar = Guitar.spawn
    guitar.send_one_way("play", context)
  end

  def play_bass
    puts "Conductor says: play bass"
    bass = Bass.spawn
    bass.send_one_way("play", context)
  end
end
