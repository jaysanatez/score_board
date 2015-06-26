f = Sport.create(:name => "Football", :male => true)
b = Sport.create(:name => "Basketball", :male => true)

neb = School.create(:name => "Nebraska")
msu = School.create(:name => "Missouri State")
asu = School.create(:name => "Arizona State")

Team.create(:school_id => neb.id, :sport_id => f.id)
Team.create(:school_id => neb.id, :sport_id => b.id)
Team.create(:school_id => msu.id, :sport_id => b.id)
Team.create(:school_id => asu.id, :sport_id => f.id)
Team.create(:school_id => asu.id, :sport_id => b.id)

Team.all.each do |t|
	Season.create(:school_id => t.school_id, :sport_id => t.sport_id, :year => 2015)
end

Season.create(:school_id => 1, :sport_id => 1, :year => 2014)
Season.create(:school_id => 1, :sport_id => 1, :year => 2013)
Season.create(:school_id => 1, :sport_id => 1, :year => 2012)