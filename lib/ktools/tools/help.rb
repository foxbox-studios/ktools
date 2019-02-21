module KTools
  module Tools
    class Help
      def self.display
        puts logo
      end

      def self.logo
        ascii = <<~HEREDOC
          .----.....``..----...:/``````
              .----.....``..-----:/+++:....
              -----.....``..::/++++++o+----
          `````:+---...-:.`-/++++++++oo/`````
          ````:++///-:++-./+++++++++oo:......
          ::::+++++++++-```/o+++++oo+.```````
          .../+/:/++++o+-.`:+++ooo+:-````````
          ..:++/+//++oooo+++++++++++.........
          `:++////++oooooooo+++++++o:........
          ///:////++oooooooo++++++++o........
          -:/-./++++++++oo++++++++++o/-------
          :::..-+++++++++++++++++++++o-......
          -:..../++++++++++++++++++++o+......
          `......+++++++++++++++++++++o/:::::
          .......:++++++++++++++++++++o/.....
          ......../++++++++++++++++++++s:....
          ........-++++++++++++//::++++-o:```
          ........./++++//+/--.-----.:/+/+-..
          `````````.:++o-.o---.-----.``-+/``-
          ----------:/+/-:o:-------.````.:+/:
          :::::::::::/o/-:/.``````.-------+//
          :::::::::::+/..--........``````./::
          ----------:+::::-........``````./::
          ..........++:------------.`````./::
        HEREDOC
      end
    end
  end
end