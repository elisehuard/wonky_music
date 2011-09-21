require 'music'

class Musician < Akka::UntypedActor
  include Music
  def self.spawn
    actor = Akka::Actors.actor_of { new }
    actor.set_dispatcher(Akka::Dispatchers.newThreadBasedDispatcher(actor))
    actor.start
  end
  
  def onReceive(msg)
    case msg
    when "play"
      @conductor = context.sender.get
      @conductor = Akka::Actors.registry.actor_for(@conductor.uuid).get
      play(@conductor)
    else
      puts "msg: #{msg}"
    end
  end
end

class Guitar < Musician
  def play(conductor)
    puts "  guitar says: ok boss"
    play_mp3("guitar.mp3")
    puts "  guitar says: done playing guitar"
    conductor.send_one_way("done guitar")
  end
end

class Bass < Musician
  def play(conductor)
    puts "  bass says: ok boss"
    play_mp3("bass.mp3")
    puts "  bass says: done playing bass"
  end
end

class Drum < Musician
  def play(conductor)
    puts "  drum says: ok boss"
    play_mp3("drum.mp3")
    puts "  drum says: done drumming"
    conductor.send_one_way("done drumming")
  end
end

class EndDrum < Musician
  def play(conductor)
    play_mp3("end_drum.mp3")
  end
end
