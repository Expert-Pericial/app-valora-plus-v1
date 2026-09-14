-- Create analysis table for PDF analysis tracking
CREATE TABLE IF NOT EXISTS analysis (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    workshop_id UUID NOT NULL REFERENCES workshops(id) ON DELETE CASCADE,
    pdf_url TEXT,
    pdf_filename TEXT,
    status TEXT NOT NULL DEFAULT 'processing' CHECK (status IN ('processing', 'pending_verification', 'pending_costs', 'completed', 'failed')),
    analysis_month DATE NOT NULL DEFAULT DATE_TRUNC('month', CURRENT_DATE),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for efficient queries
CREATE INDEX idx_analysis_workshop_id ON analysis(workshop_id);
CREATE INDEX idx_analysis_status ON analysis(status);
CREATE INDEX idx_analysis_month ON analysis(analysis_month);

-- Enable RLS
ALTER TABLE analysis ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can view their own workshop analysis" ON analysis
    FOR SELECT USING (
        workshop_id IN (
            SELECT id FROM workshops 
            WHERE id IN (
                SELECT workshop_id FROM profiles 
                WHERE id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert analysis for their workshop" ON analysis
    FOR INSERT WITH CHECK (
        workshop_id IN (
            SELECT id FROM workshops 
            WHERE id IN (
                SELECT workshop_id FROM profiles 
                WHERE id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update their own workshop analysis" ON analysis
    FOR UPDATE USING (
        workshop_id IN (
            SELECT id FROM workshops 
            WHERE id IN (
                SELECT workshop_id FROM profiles 
                WHERE id = auth.uid()
            )
        )
    );

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_analysis_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for updated_at
CREATE TRIGGER trigger_analysis_updated_at
    BEFORE UPDATE ON analysis
    FOR EACH ROW
    EXECUTE FUNCTION update_analysis_updated_at();

-- Create storage bucket for PDFs if it doesn't exist
INSERT INTO storage.buckets (id, name)
VALUES ('analysis-pdfs', 'analysis-pdfs')
ON CONFLICT (id) DO NOTHING;

-- Create storage policies for PDFs
CREATE POLICY "Users can upload PDFs for their workshop" ON storage.objects
    FOR INSERT WITH CHECK (
        bucket_id = 'analysis-pdfs' AND
        auth.uid() IS NOT NULL
    );

CREATE POLICY "Users can view PDFs for their workshop" ON storage.objects
    FOR SELECT USING (
        bucket_id = 'analysis-pdfs' AND
        auth.uid() IS NOT NULL
    );

CREATE POLICY "Users can delete PDFs for their workshop" ON storage.objects
    FOR DELETE USING (
        bucket_id = 'analysis-pdfs' AND
        auth.uid() IS NOT NULL
    );