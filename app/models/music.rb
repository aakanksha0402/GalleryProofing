class Music < ActiveRecord::Base
  belongs_to :music_category
  has_attached_file :song
  validates_attachment_content_type :song, content_type: [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]

  has_attached_file :photo
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  THEME = [['Action/Sports', 'Action/Sports'],['Bar/Bat Mitzvah','Bar/Bat Mitzvah'],['Birthday','Birthday'],['Boudoir/Glamour','Boudoir/Glamour'],['Campus Life/Senior','Campus Life/Senior'],['Celebration-Party','Celebration-Party'],['Children-Family','Children-Family'],['Corporate/Motivation','Corporate/Motivation'],['Fashion','Fashion'],['Halloween','Halloween'],['Holiday','Holiday'],['Love','Love'],['Memorial','Memorial'],['Nature/landscape','Nature/landscape'],['Pets/Wildlife','Pets/Wildlife'],['Wedding','Wedding']]

  STYLE = [['Acoustic','Acoustic'],['Adult Contemporary','Adult Contemporary'],['African','African'],['Alternative','Alternative'],['Americana','Americana'],['Big Band','Big Band'],['Bluegrass','Bluegrass'],['Blues','Blues'],['Celtic','Celtic'],['Childrens','Childrens'],['Christian','Christian'],['Classical','Classical'],['Country','Country'],['Dance','Dance'],['Downtempo','Downtempo'],['Easy Listening','Easy Listening'],['Electronic','Electronic'],['Experimental','Experimental'],['Folk','Folk'],['French/Parisian','French/Parisian'],['Funk','Funk'],['Gospel','Gospel'],['Hawaiian','Hawaiian'],['Hip Hop','Hip Hop'],['House','House'],['Indian','Indian'],['Industrial','Industrial'],['Inspirational','Inspirational'],['Irish','Irish'],['Israeli','Israeli'],['Italian','Italian'],['Jazz','Jazz'],['Jewish','Jewish'],['Latin','Latin'],['Lounge','Lounge'],['Native American','Native American'],['New Age','New Age'],['New Thought','New Thought'],['Opera','Opera'],['Orchestral','Orchestral'],['Pop','Pop'],['Progressive','Progressive'],['Punk','Punk'],['R&B','R&B'],['Rap','Rap'],['Reggae','Reggae'],['Rock','Rock'],['Salsa','Salsa'],['Singer-Songwriter','Singer-Songwriter'],['Ska','Ska'],['Smooth Jazz','Smooth Jazz'],['Soul','Soul'],['Standards','Standards'],['Surf','Surf'],['Swing','Swing'],['Trip Hop','Trip Hop'],['Urban','Urban'],['World','World']]

  MOOD = [['Aggressive','Aggressive'],['Angry','Angry'],['Atmospheric','Atmospheric'],['Bittersweet','Bittersweet'],['Calm','Calm'],['Celebration','Celebration'],['Charming','Charming'],['Cinematic','Cinematic'],['Cynical','Cynical'],['Dark','Dark'],['Dramatic','Dramatic'],['Driving','Driving'],['Edgy','Edgy'],['Epic','Epic'],['Exotic','Exotic'],['Frenetic','Frenetic'],['Frustrated','Frustrated'],['Fun','Fun'],['Funky','Funky'],['Funny','Funny'],['Grooving','Grooving'],['Happy','Happy'],['Hard','Hard'],['Haunting','Haunting'],['Hopeful','Hopeful'],['Hypnotic','Hypnotic'],['Industrial','Industrial'],['Intense','Intense'],['Introspective','Introspective'],['Laid-Back','Laid-Back'],['Lively','Lively'],['Lonely','Lonely'],['Loving','Loving'],['Lush','Lush'],['Poignant','Poignant'],['Political','Political'],['Pumping','Pumping'],['Quirky','Quirky'],['Rhythmic','Rhythmic'],['Rockin','Rockin'],['Romantic','Romantic'],['Sad','Sad'],['Sensual','Sensual'],['Sexy','Sexy'],['Soft','Soft'],['Sophisticated','Sophisticated'],['Soulful','Soulful'],['Sparse','Sparse'],['Tender','Tender'],['Uplifting','Uplifting'],['Whimsical','Whimsical'],['Wistful','Wistful']]

  SONG_TYPE = [['Vocal','Vocal'],['Instrumental','Instrumental']]

  TEMPO = [['Fast','Fast'],['Medium','Medium'],['Slow','Slow']]

  INSTRUMENT = [['Guitar','Guitar'],['Violin','Violin'],['Tabla','Tabla'],['Flute','Flute'],['Accordian','Accordian'],['Alto Sexophone','Alto Sexophone'],['Bagpipes','Bagpipes'],['Drums','Drums'],['Piano','Piano']]

  ARTIST = [['Armaan Malik','Armaan Malik'],['Arijit Singh','Arijit Singh'],['XYZ','XYZ'],['ABC','ABC'],['POI','POI'],['QWERTY','QWERTY'],['MLP','MLP']]

  scope :theme, lambda{|theme| where("musics.theme = ?", theme)}
  scope :style, lambda{|style| where("musics.style = ?", style)}
  scope :mood, lambda{|mood| where("musics.mood = ?", mood)}
  scope :song_type, lambda{|song_type| where("musics.song_type = ?", song_type)}
  scope :tempo, lambda{|tempo| where("musics.tempo = ?", tempo)}
  scope :instrument, lambda{|instrument| where("musics.instrument = ?", instrument)}
  scope :artist, lambda{|artist| where("musics.artist = ?", artist)}
  scope :title, lambda{|title| where("musics.title ILIKE ? ","%#{title}%")}
end
