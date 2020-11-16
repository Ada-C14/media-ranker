module WorksHelper

  def work_lookup(work_id)
    @works = Work.all
    work = @works.find_by(id: work_id)
    return work.title
  end
end
