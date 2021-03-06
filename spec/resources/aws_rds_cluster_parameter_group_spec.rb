require_relative '../spec_helper'

describe GeoEngineer::Resources::AwsRdsClusterParameterGroup do
  common_resource_tests(described_class, described_class.type_from_class_name)

  describe "#_fetch_remote_resources" do
    it 'should create list of hashes from returned AWS SDK' do
      rds = AwsClients.rds
      stub = rds.stub_data(
        :describe_db_cluster_parameter_groups,
        {
          db_cluster_parameter_groups: [
            {
              db_cluster_parameter_group_name: 'name1',
              db_parameter_group_family: 'aurora-postgresql9.6'
            }
          ]
        }
      )
      rds.stub_responses(:describe_db_cluster_parameter_groups, stub)
      remote_resources =
        GeoEngineer::Resources::AwsRdsClusterParameterGroup._fetch_remote_resources(nil)
      expect(remote_resources.length).to eq 1
    end
  end
end
