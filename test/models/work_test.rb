require "test_helper"

describe Work do
  let (:work){
    Work.create!(
        category: "album",
        title: "test",
        creator: "testor",
        publication_year: 2020,
        description: "testing")
  }


end
