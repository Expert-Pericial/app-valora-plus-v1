-- Add trigger to automatically call increment_analysis_count when an analysis is created
-- This ensures that paid analyses are properly decremented from user balance

CREATE OR REPLACE FUNCTION trigger_increment_analysis_count()
RETURNS TRIGGER AS $$
DECLARE
  analysis_result JSONB;
BEGIN
  -- Call increment_analysis_count to handle the analysis counting logic
  -- This will consume paid analyses if available, or handle billing
  SELECT increment_analysis_count() INTO analysis_result;
  
  -- Log the result for debugging (optional)
  RAISE LOG 'Analysis count incremented for user %: %', auth.uid(), analysis_result;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger that fires AFTER INSERT on analysis table
CREATE TRIGGER trigger_analysis_count_increment
  AFTER INSERT ON analysis
  FOR EACH ROW
  EXECUTE FUNCTION trigger_increment_analysis_count();

-- Grant necessary permissions
GRANT EXECUTE ON FUNCTION trigger_increment_analysis_count() TO authenticated;